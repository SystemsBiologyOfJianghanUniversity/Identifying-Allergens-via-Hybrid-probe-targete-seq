#----------------------------------------------#
#--------parsing parameters
#----------------------------------------------#
args=(commandArgs(TRUE))

if(length(args)==0){
   
    ##supply default values
        stop("Target file is required\n")
}else{
    for(i in 1:length(args)){
      eval(parse(text=args[[i]]))
    }
}

#----------------------------------------------#
#-------- check parameters
#----------------------------------------------#
if(!exists("f"))
{
	stop("A input file is needed\n")
}

if(!file.exists(f))
{
	stop(paste("The input file ",f,"does not exist\n"))
}

#----------------------------------------------#
#-------- Load allergen information
#----------------------------------------------#
geneInfo <- read.csv("allergens_annotation.csv",as.is=T)
	

#----------------------------------------------#
#-------- Add allergen informtation
#----------------------------------------------#
x<-read.table(f,as.is=T)

x$index = 1:nrow(x)
x$GeneAllergen = geneInfo[match(x$V1,geneInfo[,6]),2]
x$GeneLineage = geneInfo[match(x$V1,geneInfo[,6]),3]
x$GeneBiochemical = geneInfo[match(x$V1,geneInfo[,6]),4]


	
for(i in 1:ncol(x))
{
	x[,i]=gsub("\\n"," ",x[,i])
}
	names(x)[1:2]=c("DetectedGene","ReadCount")

outF = paste(f,".anno",sep="")	
write.table(x,outF,row.names=F,sep="\t",col.names=T,quote=F)
