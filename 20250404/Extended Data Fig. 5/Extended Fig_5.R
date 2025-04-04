install.packages("ggseqlogo")
library(dplyr)
library(ggseqlogo)
library(ggplot2)
#==============================================================Extended Fig.5a-c
setwd("E:/sunny文件/瓜氨酸化蛋白抗原的发现/整理文章用图/返修/代码和数据复核/20250330 figure+code/Extended Data Fig. 5/eFig 5a-c")
rm(list = ls())
df = readxl::read_xlsx("bigru_3_64.xlsx", sheet=1) %>% 
  filter(nchar_8AApep==17)
df$seq17aa = gsub("X","R",df$seq17aa)
table(df$group)
df = df %>% arrange(pred)
dat=list(pos_all=df$seq17aa[df$group=="all_pos"],neg_all=df$seq17aa[df$group=="all_neg"],neg_top=df$seq17aa[1:209])

ggseqlogo(dat, seq_type = "aa", scale="free", method = "probability", nrow=4, stack_width=0.8)+
  scale_y_continuous(expand = c(0,0), limits = c(0,1))+
  theme(axis.line.y=element_line(color="black"),
        axis.ticks.y=element_line(color="black"),
        axis.text.x = element_blank())
ggsave("eFig 5a-c.pdf", width = 4, height = 7)
#==============================================================Extended Fig.5d-i
setwd("E:/sunny文件/瓜氨酸化蛋白抗原的发现/整理文章用图/返修/代码和数据复核/20250330 figure+code/Extended Data Fig. 5/eFig 5d-i")
rm(list = ls())
# pos
pos = data.table::fread("DAVID pos.txt")%>%filter(PValue<0.05)
table(pos$Category)

bp = pos %>% filter(Category=="GOTERM_BP_DIRECT") %>% arrange(PValue)
bp = bp[1:5]%>%arrange(-PValue)%>%mutate(order=letters[1:5], group=rep("GOBP pos",5))

cc = pos %>% filter(Category=="GOTERM_CC_DIRECT") %>% arrange(PValue)
cc = cc[1:5]%>%arrange(Count)%>%mutate(order=letters[1:5], group=rep("GOCC pos",5))

mf = pos %>% filter(Category=="GOTERM_MF_DIRECT") %>% arrange(PValue)
mf = mf[1:5]%>%arrange(Count)%>%mutate(order=letters[1:5], group=rep("GOMF pos",5))


# neg
neg = data.table::fread("DAVID neg.txt")%>%filter(PValue<0.05)

bp1 = neg %>% filter(Category=="GOTERM_BP_DIRECT") %>% arrange(PValue)
bp1 = bp1[1:5]%>%arrange(Count)%>%mutate(order=letters[1:5], group=rep("GOBP neg",5))

cc1 = neg %>% filter(Category=="GOTERM_CC_DIRECT") %>% arrange(PValue)
cc1 = cc1[1:5]%>%arrange(Count)%>%mutate(order=letters[1:5], group=rep("GOCC neg",5))

mf1 = neg %>% filter(Category=="GOTERM_MF_DIRECT") %>% arrange(PValue)
mf1 = mf1[1:5]%>%arrange(Count)%>%mutate(order=letters[1:5], group=rep("GOMF neg",5))



data = rbind(mf, mf1, bp, bp1, cc, cc1)
data$Description = gsub(".*\\~","",data$Term)%>%stringr::str_to_title() 
data$y = paste(data$order, data$Description)

group = unique(data$group)


p_list <- lapply(group, function(x){
  ggplot(data[data$group==x,], aes(Count, y, fill=-log10(PValue)))+
    geom_bar(stat="identity", width = .6, color="transparent")+
    scale_fill_gradient(high="#FCA305", low="#A0CEE2")+
    scale_x_continuous(expand = c(0,0))+
    #scale_y_discrete(label=data$Description[data$group==x])+
    theme_minimal()+
    theme(axis.line = element_line(color="black", linewidth = .7),
          axis.ticks = element_line(color="black", linewidth = .7))+
    ggtitle(x)
})

pdf("eFig 5d-i.pdf", width = 18, height = 6)
do.call(gridExtra::grid.arrange,c(p_list, ncol=3))
dev.off()

