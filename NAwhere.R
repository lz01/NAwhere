## Function NAwhere takes a data.frame or a matrix as input


NAwhere = function(data)
{
	require(ggplot2)
	require(tidyr)
	
	n = nrow(data)
	p = ncol(data)
	
	if(is.matrix(data))
	{
			data = as.data.frame(data)
			names(data) = c(1:p)
	}

	d_gathered = gather(data, key="Variable", value = "Value")
	d_gathered$isna = is.na(d_gathered$Value)
	d_gathered$Row = rep(1:n,p)
	
	## Defining colour
	mycols = c("TRUE" = "red4", "FALSE" = "gray26")
	
	## Plotting
	ggplot(d_gathered,aes(Variable,Row,fill=isna)) +
	geom_raster() +
	coord_cartesian(ylim = c(n,1), expand = FALSE) +
	scale_fill_manual(values = mycols, name = "is NA") +
	scale_y_continuous(trans = "reverse") +
	scale_x_discrete(position = "top") +
	theme(axis.text.x = element_text(angle=45, hjust=0))
	
}