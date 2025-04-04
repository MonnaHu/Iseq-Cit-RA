library(dplyr)
library(ggplot2)
library(ComplexHeatmap)
library(circlize)
#==================================================================Extended Fig.3a
setwd("E:/sunny文件/瓜氨酸化蛋白抗原的发现/整理文章用图/返修/代码和数据复核/20250330 figure+code/Extended Data Fig. 3/eFig. 3a")
rm(list = ls())
result=read.csv("eFig. 3a.csv")
names(result)
table(result$sig_mean)

ggplot(result, aes(x=log2(RO_mean), y=-log10(p_t), color=sig_mean))+
  geom_point()+
  geom_hline(yintercept = -log10(0.05), linetype=2,linewidth=.5, color="#BBBBBB")+
  geom_vline(xintercept = c(log2(1.2),-log2(1.2)), linetype=2,linewidth=.5, color="#BBBBBB")+
  scale_color_manual(values = c("#5D669F","#BFBFBF","#AF322F"))+
  theme_test()+
  theme(axis.line = element_blank(),
        panel.border = element_rect(linewidth=.8),
        axis.ticks = element_line(linewidth=.8),
        axis.ticks.length = unit(1.25,"mm"))
ggsave("volcano peptides.pdf", width = 3.8, height = 3)
#==================================================================Extended Fig.3b
setwd("E:/sunny文件/瓜氨酸化蛋白抗原的发现/整理文章用图/返修/代码和数据复核/20250330 figure+code/Extended Data Fig. 3/eFig. 3b")
rm(list=ls())
dat1=readxl::read_xlsx("eFig 3b.xlsx", sheet=1)
data = dat1[,10:17] %>% data.frame(); data[,] = lapply(data[,], as.numeric)
range(data, na.rm=T)
rownames(data)=dat1$ID_PA

data[data==0]=NA
data$ratio=log2(apply(data[,5:8],1, mean, na.rm=T) / apply(data[,1:4],1, mean, na.rm=T))
data$ID=gsub("\\(.*","",dat1$Gene_position)
data$n_OA=4-rowSums(is.na(data[,1:4])); range(data$n_OA)
data$n_RA=4-rowSums(is.na(data[,5:8])); range(data$n_RA)
data$unique=rep(1,nrow(data))

dat=data[data$n_OA >= 2 & data$n_RA >= 2, c("ID", "ratio", "unique")] %>% group_by(ID) %>% summarise(log2sum=sum(ratio), n=sum(unique))
dat$type=ifelse(dat$log2sum > 0.5, "up", ifelse(dat$log2sum<(-0.5), "down", "ns")); table(dat$type)
write.csv(dat,"The citrullination state change (∆Ps).csv", row.names = F)


ggplot(dat, aes(n, log2sum, color=type))+
  geom_point(size=3)+
  theme_classic()+
  geom_hline(yintercept = c(0.5,-0.5), linetype=2, color="#CCCCCC")+
  labs(x="No. of citrullinated peptides", y="ΔCs value")+
  scale_color_manual(values = c('#154399', "#BBBBBB","#B81C23"))+
  scale_x_sqrt()+
  theme(axis.text = element_text(color="black"), axis.ticks = element_line(color="black", linewidth = .7),
        axis.line = element_line(linewidth = .7), axis.ticks.length = unit(1.25,"mm"))
ggsave("The citrullination state change (∆Cs).pdf", width = 4.25, height = 3)

table(dat$type)

df=read.csv("The citrullination state change (∆Ps).csv")
ggplot(df, aes(n, log2sum, color=type))+
  geom_point(size=3)+
  theme_classic()+
  geom_text(aes(label=ID), color="black")+
  geom_hline(yintercept = c(0.5,-0.5), linetype=2, color="#CCCCCC")+
  labs(x="No. of citrullinated peptides", y="ΔCs value")+
  scale_color_manual(values = c('#154399', "#BBBBBB","#B81C23"))+
  theme(axis.text = element_text(color="black"), axis.ticks = element_line(color="black", linewidth = .7),
        axis.line = element_line(linewidth = .7), axis.ticks.length = unit(1.25,"mm"))
ggsave("∆Cs text.pdf", width = 7, height = 6)






