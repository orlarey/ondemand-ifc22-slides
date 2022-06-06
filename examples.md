
# Example 1, block-diagram

	process = button("play"), _ : ondemand(_);

![](demo-ifc-2022/t1-bd.pdf)

# Example 1, instruction graph

![](demo-ifc-2022/t1.pdf)


# Example 2, block-diagram

	process = _ <: ondemand(_)(button("play1")), ondemand(_)(button("play2"));

![](demo-ifc-2022/t2-bd.pdf)

# Example 2, instruction graph

![](demo-ifc-2022/t2.pdf)


# Example 3, block-diagram

	process = _ <: ondemand(_)(button("play")), ondemand(_)(button("play"));

![](demo-ifc-2022/t3-bd.pdf)

# Example 3, instruction graph

![](demo-ifc-2022/t3.pdf)


# Example 4, block-diagram

	foo = 1:+~_;
	process = ondemand(foo)(button("play"));


![](demo-ifc-2022/t4-bd.pdf)

# Example 4, instruction graph

![](demo-ifc-2022/t4.pdf)



# Example 5, block-diagram

	foo = 1:+~_;
	process = ondemand(foo)(button("play1")), ondemand(foo)(button("play2"));


![](demo-ifc-2022/t5-bd.pdf)

# Example 5, instruction graph

![](demo-ifc-2022/t5.pdf)




# Example 6, block-diagram

	foo = 1:+~_;
	process = ondemand(foo)(button("play")), ondemand(foo)(button("play"));


![](demo-ifc-2022/t6-bd.pdf)

# Example 6, instruction graph

![](demo-ifc-2022/t6.pdf)



# Example 7, block-diagram

	process = ondemand(@(10))(button("play"));


![](demo-ifc-2022/t7-bd.pdf)

# Example 7, instruction graph

![](demo-ifc-2022/t7.pdf)



# Example 8, block-diagram

	process = _ <: ondemand(@(10))(button("play")), ondemand(@(20))(button("play"));


![](demo-ifc-2022/t8-bd.pdf)

# Example 8, instruction graph

![](demo-ifc-2022/t8.pdf)

