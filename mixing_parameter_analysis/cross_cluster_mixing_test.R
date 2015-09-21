# MNM package
## X is sample of different mixing parameters
## g is factor variable indicating cluster
load("/Users/bdesmarais/Downloads/Mixing_Parameter_MH_Chain_All_Counties.Rdata")

# package that impliments mv rank test
library(MNM)

ucounties <- unique(Mixing_Parameter_MH_Chain_All_Counties$county_name)

ctest_results <- list()

for(i in 1:length(ucounties)){
	subdati <- subset(Mixing_Parameter_MH_Chain_All_Counties,county_name==ucounties[i])
	testdati <- NULL
	for(c in c("Cluster-1","Cluster-2","Cluster-3","Cluster-4")){
		datc <- subset(subdati,cluster_indicator==c)
		datc <- data.frame(as.matrix(t(datc[-1,-c(1:3)])),c)
		names(datc) <- c("X2","X3","X4","c")
		testdati <- rbind(testdati,datc)
	}
	ctest_results[[i]] = list(data=testdati,test.result=mv.Csample.test(testdati[, 1:3] ,testdati$c,score="r"))
	print(ctest_results[[i]]$test.result)
}

names(ctest_resuts) <- ucounties

save(list="ctest_results",file="/Users/bdesmarais/Downloads/mixing_parameter_test_results.RData")



