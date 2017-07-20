Stock.Quote_New <- read.csv("~/Quantitative Trading/Stock Quote_New.csv")
quotes<- Stock.Quote_New 
head(quotes)
names(quotes) <- c("stock_quote","company","quantmod_quote") #rename the header
#NYSE_Quote<- as.data.frame(quotes[,"stock_quote"]) #convert quotes to characters
#head(NYSE_Quote)

library(quantmod)

#extract BS, IS and CF of first 500 companies

for (i in 1: 500){
tryCatch({
t<- as.character(quotes[i,1])
t.f<- getFinancials(t,auto.assign = FALSE)
t.BS<- viewFinancials(t.f,type="BS",period="Q")
t.IS<- viewFinancials(t.f,type="IS",period="Q")
t.CF<- viewFinancials(t.f,type="CF",period="Q")
name.BS<-paste("BS",i,sep="")
name.IS<-paste("IS",i,sep="")
name.CF<-paste("CF",i,sep="")
assign(name.BS,t.BS)
assign(name.IS,t.IS)
assign(name.CF,t.CF)},error=function(e){}
)
}

#extract revenue

for(i in 1:500){
tryCatch({
assign(paste("Rev",i,sep=""),c(1:5*0))
assign(paste("Rev",i,sep=""),get(paste("IS",i,sep=""))[1,])
},error=function(e){})}

Revenue<- matrix(data=NA,nrow=nrow(quotes),ncol=4)

#Combining all revenue data
for (i in 1:500){
  tryCatch({
  Revenue[i,]<- as.numeric(get(paste("IS",i,sep=""))["Revenue",])[1:4]},error=function(e){})}

#Save Revenue (1- 500)
write.csv(Revenue,"C:/Users/jason/OneDrive/Documents/Quantitative Trading/Revenue.csv")

#Save BS (1- 500)
for (i in 3:500){
  tryCatch({
  write.csv(get(paste("BS",i,sep="")),sprintf("C:/Users/jason/OneDrive/Documents/Quantitative Trading/BS%d.csv",i))
  },error=function(e){})}

#Save IS (1- 500)
for (i in 1:500){
  tryCatch({
    write.csv(get(paste("IS",i,sep="")),sprintf("C:/Users/jason/OneDrive/Documents/Quantitative Trading/Income Statements/IS%d.csv",i))
  },error=function(e){})}

#Save CF (1- 500)
for (i in 1:500){
  tryCatch({
    write.csv(get(paste("CF",i,sep="")),sprintf("C:/Users/jason/OneDrive/Documents/Quantitative Trading/Cash Flow Statements/CF%d.csv",i))
  },error=function(e){})}


#Extract Earnings/ Net Income

for (i in 1:500){
  tryCatch({
  assign(paste("IS",i,sep=""),read.csv(sprintf("~/Quantitative Trading/Income Statements/IS%d.csv",i),row.names=1))
  },error=function(e){})}

for (i in 1:500){
  tryCatch({
  assign(paste("NI",i,sep=""),get(paste("IS",i,sep=""))["Net Income",])}, error= function(e){})}

NI<-matrix(data=NA,ncol=4,nrow=nrow(quotes))

for (i in 1:500){
  tryCatch({
    NI[i,] <- as.numeric(get(paste("NI",i,sep="")))[1:4]},error=function(e){})}

write.csv(NI,"C:/Users/jason/OneDrive/Documents/Quantitative Trading/Net Income.csv")

#Extract Cash from Operating Activities

for (i in 1:500){
  tryCatch({
    assign(paste("CF",i,sep=""),read.csv(sprintf("~/Quantitative Trading/Cash Flow Statements/CF%d.csv",i),row.names=1))
  },error=function(e){})}

for (i in 1:500){
  tryCatch({
    assign(paste("CFO",i,sep=""),get(paste("CF",i,sep=""))["Cash from Operating Activities",])}, error= function(e){})}

CFO<- matrix(data=NA,nrow=nrow(quotes),ncol=4)

for (i in 1:500){
  tryCatch({
    CFO[i,] <- as.numeric(get(paste("CFO",i,sep="")))[1:4]},error=function(e){})}

write.csv(CFO,"C:/Users/jason/OneDrive/Documents/Quantitative Trading/Cash from Operating Activities.csv")


         

#rm(list=ls())

head(Revenue)

IS1
BS1

IS500[1,]
Rev500
IS50[1,]
Rev450

as.numeric(Rev1)


