

install.packages("cowplot")
install.packages("factoextra")
install.packages("FactoMineR")
install.packages("scales")
library(ggplot2)
library(dplyr)
library(ggpubr)
library(scales)
library(cowplot)
library(factoextra)
library(FactoMineR)
#==============================================================Extended Fig4a-d
setwd("E:/sunny文件/瓜氨酸化蛋白抗原的发现/整理文章用图/返修/代码和数据复核/20250330 figure+code/Extended Data Fig. 4/eFig. 4a,4b,4c,4d")
rm(list=ls())

d = dir(pattern = ".csv");
data=read.csv(d[1])
d1 = lapply(d, function(x){
  pca_sample = read.csv(x, row.names = 1)
  p <- ggplot(data = pca_sample, aes(x = Dim.1, y = Dim.2)) +
    geom_point(aes(color = `Responder.HM`), size = 2, alpha=1) + 
    scale_color_manual(values = c("#D72E2A","#3D7DAE")) + 
    theme(panel.grid = element_blank(), panel.background = element_rect(color = 'black', fill = 'transparent'), 
          legend.key = element_rect(fill = 'transparent'),
          strip.background = element_blank(),
          legend.position = "bottom",
          axis.text = element_text(color="black"),
          axis.line = element_line(linewidth=.8, color="black"),
          axis.ticks = element_line(linewidth=.8, color="black"),
          axis.ticks.length = unit(1.25,"mm")) + 
    labs(x =  paste('PCA1:', unique(pca_sample$pca_eig1), '%'), y = paste('PCA2:', unique(pca_sample$pca_eig2), '%'), color = '')+  
    stat_ellipse(aes(fill = `Responder.HM`), geom = 'polygon', level = 0.95, alpha = 0.2, show.legend = FALSE) +
    scale_fill_manual(values = c("#D72E2A","#3D7DAE"))
})


plot_grid(plotlist = d1, align = "h", nrow = 1)
ggsave("ML&MH  pca plasma1&2.pdf", height = 3, width = 9.8)

#==============================================================Extended Fig4
setwd("E:/sunny文件/瓜氨酸化蛋白抗原的发现/整理文章用图/返修/代码和数据复核/20250330 figure+code/Extended Data Fig. 4/eFig. 4e,4f,4g,4h,4i,4j")

rm(list=ls())
d1 = read.csv("Cohort1.csv")
d2 = read.csv("Cohort2.csv")

# MTX+LEF
d1_1 = d1 %>% filter(Drugs.HM=="MTXLEF" & c(Responder.HM=="Y"|Responder.HM=="N"))
d2_1 = d2 %>% filter(csDMARDs=="MTX+LEF" & c(Responder.HM=="Y"|Responder.HM=="N"))
df1 = as.data.frame(table(d1_1$Sex, d1_1$Responder.HM)); sum(df1$Freq)
df2 = as.data.frame(table(d2_1$Gender, d2_1$Responder.HM)); sum(df2$Freq)
df = rbind(df1 %>% mutate(dataset = "dataset 1"), df2 %>% mutate(dataset = "dataset 2"))
df
ggplot(df, aes(Var1,Freq,fill=Var2))+
  geom_bar(stat="identity",position = position_dodge(width = .9),width = .5, alpha=1)+
  scale_fill_manual(values = c("#737aac","#af322f"))+
  scale_y_continuous(expand = c(0,0), limits = c(0,60), breaks = c(0,20,40,60))+
  geom_text(aes(label=Freq), position = position_dodge(width = .9))+
  facet_wrap(.~dataset, nrow=1)+
  theme_classic()+
  theme(axis.text = element_text(color="black"),
        strip.background = element_blank(),
        axis.text.x = element_text(angle=90),
        axis.line = element_line(linewidth=.8, color="black"),
        axis.ticks = element_line(linewidth=.8, color="black"),
        axis.ticks.length = unit(1.25,"mm"))
ggsave("barplot gender&response of MTXLEF.pdf", width = 4, height = 3)


d = rbind(d1_1[,c("Responder.HM","Age")] %>% mutate(dataset = "dataset 1"), d2_1[,c("Responder.HM","Age")] %>% mutate(dataset = "dataset 2"))
table(d$dataset)

ggplot(d, aes(dataset,as.numeric(Age),fill=Responder.HM,color=Responder.HM))+
  geom_violin(alpha=.3, color="black",position = position_dodge(width = .8), width=.8)+
  geom_boxplot(width=.3, color="black",position = position_dodge(width = .8), outlier.colour = NA)+
  geom_jitter(position = position_jitterdodge(jitter.width = .15, dodge.width = .8), size=1)+
  scale_color_manual(values = c("#737aac","#af322f"))+
  scale_fill_manual(values = c("#737aac","#af322f"))+
  scale_y_continuous(expand = c(0,0), limits = c(0,100), breaks = c(0,25,50,75,100))+
  stat_compare_means(method = "wilcox.test", label="..p.format..",label.y =90)+
  theme_classic()+
  theme(axis.text = element_text(color="black"),
        strip.background = element_blank(),
        axis.text.x = element_text(angle=90),
        axis.line = element_line(linewidth=.8, color="black"),
        axis.ticks = element_line(linewidth=.8, color="black"),
        axis.ticks.length = unit(1.25,"mm"))
ggsave("violin age&response of MTXLEF.pdf", width = 4.5, height = 3)

d1_1[,7:11] = lapply(d1_1[,7:11],as.numeric)
d2_1[,9:13] = lapply(d2_1[,9:13],as.numeric)
d1_1[,7:11] = lapply(d1_1[,7:11],scale)
d2_1[,9:13] = lapply(d2_1[,9:13],scale)
dd = rbind(d1_1[,c("Responder.HM","DAS28.CRP.HM","TJC","SJC","CRP")] %>% mutate(dataset = "dataset 1"), d2_1[,c("Responder.HM","DAS28.CRP.HM","TJC","SJC","CRP")] %>% mutate(dataset = "dataset 2"))
table(dd$dataset)
ddd = reshape2::melt(dd, id.vars=c("Responder.HM","dataset"), measure.vars=2:5)
ggplot(ddd, aes(variable,as.numeric(value),fill=Responder.HM,color=Responder.HM))+
  #geom_violin(alpha=.3, color="black",position = position_dodge(width = .8), width=.8)+
  geom_boxplot(width=.5, color="black",position = position_dodge(width = .8), outlier.colour = NA)+
  geom_jitter(position = position_jitterdodge(jitter.width = .25, dodge.width = .8), size=1)+
  scale_color_manual(values = c("#737aac","#af322f"))+
  scale_fill_manual(values = c("white","white"))+
  scale_y_continuous(expand = c(0,0),limits = c(-2.5,6))+
  stat_compare_means(method = "wilcox.test", label="p.signif",label.y =5)+
  facet_wrap(.~dataset, nrow=1)+
  theme_classic()+
  theme(axis.text = element_text(color="black"),
        strip.background = element_blank(),
        axis.text.x = element_text(angle=90),
        axis.line = element_line(linewidth=.8, color="black"),
        axis.ticks = element_line(linewidth=.8, color="black"),
        axis.ticks.length = unit(1.25,"mm"))
ggsave("boxplot 4cli&response of MTXLEF.pdf", width = 6, height = 3.5)




#############################################################################################
# MTX+HCQ
d1_1 = d1 %>% filter(Drugs.HM=="MTXHCQ" & c(Responder.HM=="Y"|Responder.HM=="N"))
d2_1 = d2 %>% filter(csDMARDs=="MTX+HCQ" & c(Responder.HM=="Y"|Responder.HM=="N"))
df1 = as.data.frame(table(d1_1$Sex, d1_1$Responder.HM)); sum(df1$Freq)
df2 = as.data.frame(table(d2_1$Gender, d2_1$Responder.HM)); sum(df2$Freq)
df = rbind(df1 %>% mutate(dataset = "dataset 1"), df2 %>% mutate(dataset = "dataset 2"))
df
ggplot(df, aes(Var1,Freq,fill=Var2))+
  geom_bar(stat="identity",position = position_dodge(width = .9),width = .5, alpha=1)+
  scale_fill_manual(values = c("#737aac","#af322f"))+
  scale_y_continuous(expand = c(0,0), limits = c(0,60), breaks = c(0,20,40,60))+
  geom_text(aes(label=Freq), position = position_dodge(width = .9))+
  facet_wrap(.~dataset, nrow=1)+
  theme_classic()+
  theme(axis.text = element_text(color="black"),
        strip.background = element_blank(),
        axis.text.x = element_text(angle=90),
        axis.line = element_line(linewidth=.8, color="black"),
        axis.ticks = element_line(linewidth=.8, color="black"),
        axis.ticks.length = unit(1.25,"mm"))
ggsave("barplot gender&response of MTXHCQ.pdf", width = 4, height = 3)

d = rbind(d1_1[,c("Responder.HM","Age")] %>% mutate(dataset = "dataset 1"), d2_1[,c("Responder.HM","Age")] %>% mutate(dataset = "dataset 2"))
table(d$dataset)

ggplot(d, aes(dataset,as.numeric(Age),fill=Responder.HM,color=Responder.HM))+
  geom_violin(alpha=.3, color="black",position = position_dodge(width = .8), width=.8)+
  geom_boxplot(width=.3, color="black",position = position_dodge(width = .8), outlier.colour = NA)+
  geom_jitter(position = position_jitterdodge(jitter.width = .15, dodge.width = .8), size=1)+
  scale_color_manual(values = c("#737aac","#af322f"))+
  scale_fill_manual(values = c("#737aac","#af322f"))+
  scale_y_continuous(expand = c(0,0), limits = c(0,100), breaks = c(0,25,50,75,100))+
  stat_compare_means(method = "wilcox.test", label="..p.format..",label.y =90)+
  theme_classic()+
  theme(axis.text = element_text(color="black"),
        strip.background = element_blank(),
        axis.text.x = element_text(angle=90),
        axis.line = element_line(linewidth=.8, color="black"),
        axis.ticks = element_line(linewidth=.8, color="black"),
        axis.ticks.length = unit(1.25,"mm"))
ggsave("violin age&response of MTXHCQ.pdf", width = 4.5, height = 3)


d1_1[,7:11] = lapply(d1_1[,7:11],as.numeric)
d2_1[,9:13] = lapply(d2_1[,9:13],as.numeric)
d1_1[,7:11] = lapply(d1_1[,7:11],scale)
d2_1[,9:13] = lapply(d2_1[,9:13],scale)
dd = rbind(d1_1[,c("Responder.HM","DAS28.CRP.HM","TJC","SJC","CRP")] %>% mutate(dataset = "dataset 1"), d2_1[,c("Responder.HM","DAS28.CRP.HM","TJC","SJC","CRP")] %>% mutate(dataset = "dataset 2"))
table(dd$dataset)
ddd = reshape2::melt(dd, id.vars=c("Responder.HM","dataset"), measure.vars=2:5)
ggplot(ddd, aes(variable,as.numeric(value),fill=Responder.HM,color=Responder.HM))+
  #geom_violin(alpha=.3, color="black",position = position_dodge(width = .8), width=.8)+
  geom_boxplot(width=.5, color="black",position = position_dodge(width = .8), outlier.colour = NA)+
  geom_jitter(position = position_jitterdodge(jitter.width = .25, dodge.width = .8), size=1)+
  scale_color_manual(values = c("#737aac","#af322f"))+
  scale_fill_manual(values = c("white","white"))+
  scale_y_continuous(expand = c(0,0),limits = c(-2.5,6))+
  stat_compare_means(method = "wilcox.test", label="p.signif",label.y =5)+
  facet_wrap(.~dataset, nrow=1)+
  theme_classic()+
  theme(axis.text = element_text(color="black"),
        strip.background = element_blank(),
        axis.text.x = element_text(angle=90),
        axis.line = element_line(linewidth=.8, color="black"),
        axis.ticks = element_line(linewidth=.8, color="black"),
        axis.ticks.length = unit(1.25,"mm"))
ggsave("boxplot 4cli&response of MTXHCQ.pdf", width = 6, height = 3.5)
