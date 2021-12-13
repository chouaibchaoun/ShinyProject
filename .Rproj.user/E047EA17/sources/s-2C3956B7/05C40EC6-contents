# importing libraries
library(readtext)
library(readr)
library(dplyr)
library(ggplot2)
library(sf)
library(tidygraph)
library(ggraph)
library(stringr)

# importing data
appearances = read_csv("./data/appearances.csv")
scenes = read_csv("./data/scenes.csv")
episodes = read_csv("./data/episodes.csv")
characters = read_csv("./data/characters.csv")

scenes_locations=st_read("data/GoTRelease/ScenesLocations.shp",crs=4326)
locations=st_read("./data/GoTRelease/Locations.shp",crs=4326)
lakes=st_read("./data/GoTRelease/Lakes.shp",crs=4326)
conts=st_read("./data/GoTRelease/Continents.shp",crs=4326)
land=st_read("./data/GoTRelease/Land.shp",crs=4326)
wall=st_read("./data/GoTRelease/Wall.shp",crs=4326)
islands=st_read("./data/GoTRelease/Islands.shp",crs=4326)
kingdoms=st_read("./data/GoTRelease/Political.shp",crs=4326)
landscapes=st_read("./data/GoTRelease/Landscape.shp",crs=4326)
roads=st_read("./data/GoTRelease/Roads.shp",crs=4326)
rivers=st_read("./data/GoTRelease/Rivers.shp",crs=4326)

# Plot Colors
colforest="#c0d7c2"
colriver="#7ec9dc"
colriver="#d7eef4"
colland="ivory"
borderland = "ivory3"
colors = c("YlOrRd", "YlGnBu","YlGn", "BuPu","RdPu","Accent", "Dark2","Paired")

# Utilities functions
get_sublocation_coord <- function(sublocation) {
  out <- tryCatch(
    {
      filter(locations , name == sublocation)$geometry %>% unique() %>% .[1]  # TODO the output is a list it might cause a problem during visualisation
    },
    error=function(cond) {
      return(NA)
    }
  )
  return (out)
}

#Plot
plot1 <- function(episode_n,saison_n){
  # Getting Data
  
  episodeID = episodes[episodes$episodeNum==episode_n & episodes$seasonNum == saison_n,]$episodeId ##getting the episode id
  
  ############# Unsed lines #########################
  Data <- scenes[scenes$episodeId == episodeID,]
  
  Data$geometry <- lapply(Data$subLocation , get_sublocation_coord)
  ###################################################
  
  
  Data2 <- scenes %>% filter(episodeId == episodeID) %>% group_by(subLocation) %>% summarize(duration = sum(duration))
  Data2_js <- locations %>% left_join(Data2,by = c("name"="subLocation"))
  
  # Constructing the map visualisation
  ggplot()+geom_sf(data=land,fill=colland,col=borderland,size=0.1)+
    geom_sf(data=islands,fill=colland,col="ivory3")+
    geom_sf(data=landscapes %>% filter(type=="forest"),fill=colforest,col=colforest,alpha=0.7)+
    geom_sf(data=rivers,col=colriver)+
    geom_sf(data=lakes,col=colriver,fill=colriver)+
    geom_sf(data=wall,col="black",size=1)+
    geom_sf(data=Data2_js,aes(size=duration/1000),color="#f564e3")+
    geom_sf_text(data= locations %>% filter(size>4,name!='Tolos'),aes(label=name),size=2.8,family="Palatino", fontface="italic",vjust=0.7)+
    theme_minimal()+coord_sf(expand = 0,ndiscr = 0)+
    scale_size_area("Durées (min) :",max_size = 16,breaks=c(30,60,120,240))+
    theme(panel.background = element_rect(fill = colriver,color=NA),legend.position = "bottom") +
    labs(title = "Repartition spaciale des scenes",x="",y="")
}


plot2 <- function(episode_n,saison_n) {
  # Getting Data
  
  episodeID = episodes[episodes$episodeNum==episode_n & episodes$seasonNum == saison_n,]$episodeId ##getting the episode id
  
  WhoDied <- characters %>% filter(! is.na(killedBy))
  LastApperance <- appearances %>% group_by(name)  %>% summarize(sceneId = max(sceneId))
  SceneIds <- scenes %>% filter(episodeId == episodeID) %>% .$sceneId
  cast <- appearances %>% filter(sceneId %in% SceneIds)
  WhoDiedE <- WhoDied  %>% left_join(LastApperance) %>% filter(! is.na(sceneId)) %>% group_by(name) %>% summarize(sceneId = max(sceneId) ) %>% inner_join(cast)
  Dead <- WhoDiedE$name
  WhoDied_In <- WhoDied %>% filter(name %in% Dead) %>% left_join(WhoDiedE)
  
  ##ggplot(WhoDied_In)+ geom_bar(aes(y=killedBy)) +theme_bw()+ggtitle("Nmae by scene Id")
  Died <- WhoDied_In %>% select(killedBy,name)
  graphroutes <- as_tbl_graph(Died)
  graph_routes <- graphroutes %>% activate(nodes) %>% mutate( title = str_to_title(name),label = str_replace_all(title, " ", "\n"))
  
  ggraph(graph_routes, layout = 'graphopt') + 
    geom_edge_link(aes(start_cap = label_rect(node1.name),
                       end_cap = label_rect(node2.name)), 
                   arrow = arrow(length = unit(4, 'mm'))) + 
    geom_node_text(aes(label = name))

}
plot3 <- function(episode_n,saison_n) {
  # Getting Data
  
  episodeID = episodes[episodes$episodeNum==episode_n & episodes$seasonNum == saison_n,]$episodeId ##getting the episode id
  SceneIds <- scenes %>% filter(episodeId == episodeID) %>% .$sceneId
  cast <- appearances %>% filter(sceneId %in% SceneIds)
  
  Duration <- cast %>% left_join(scenes) %>% group_by(name) %>% summarize(duration = sum(duration)) %>% arrange(desc(duration))
  
  ggplot(data=Duration)+
    geom_bar(aes(x=name,y=duration),stat = 'identity')+
    scale_x_discrete("Cast Members")+
    scale_y_continuous("Total duration of appearances")+
    coord_flip()
}
