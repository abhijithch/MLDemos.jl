using XGBoost

dtrain=readcsv("./data/higgsml/training.csv",header=true)
data=dtrain[1][:,2:31]
labels  = dtrain[1][:,33]

label=zeros(length(labels))
for i=1:length(labels)
    if labels[i]=="s"
        label[i]=1.0
    end
end

weight=dtrain[1][:,32].*550000/250000

sum_wpos=0
for i=1:length(label)
    if label[i]==1.0
        sum_wpos=sum_wpos+weight[i]
    end
end

sum_wneg=0
for i=1:length(label)
    if label[i]==0.0
        sum_wneg=sum_wneg+weight[i]
    end
end

data=convert(Array{Float64,2},data)

idx0 = findin(data,0.0)
data[idx0]=eps()
idx9=findin(data, -999.0)
data[idx9]=0.0

datas=sparse(data)

param = ["objective"=>"binary:logitraw", "scale_pos_weight"=>sum_wneg/sum_wpos, "eta"=>0.1,"max_depth"=>6,"eval_metric"=>"auc","silent"=>1,"nthread"=>16];
num_round = 120
xgmat = DMatrix(datas,label=label)

bst = xgboost(xgmat, num_round)

