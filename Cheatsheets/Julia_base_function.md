# A collection of Julia base functions
Many are often applicable to several types and data structures. 

## Dicts

##### get a key-value pair: get(collection, key, default)   
From a dict, **get** the value associated with a defined key, and if the key is
not present, output another value (default) - this is another way of doing a
conventional index based look up: `dict[key]` 

##### reverse lookup: findall(isequal(value), dict)  
Compared to a conventional forward lookup, whereby we search for the value
associated with a specific key, here we search for the presence of values in
the dict irrespective of the key, and often we don't know the key itself. This is a combination of two functions. 


## Tuples 

##### split a tuple based on a character: split(tuple, 'character') 
We can split a tuple (or string) and use any character as the splitting delimiter. See for instance;
```
  addr = "julius.caesar@rome"
  uname, domain = split(addr, '@'); 
``` 
We can assign the various components of the string/tuple to their own tuples,
and as you expect, we want the number of tuples to correspond to the number of
elements after splitting.    

##### get the product and the remainder of a division: divrem(a, b)
This will take two numbers and perform a division operation with them, then
return the product (quotient), and the remainder of the operation as two
tuples, which themselves can be assigned to new variables; `q, r = divrem(90,
23)`.    

##### get the minimum and maximum of a sequence: minmax('1', '2') 
Imagine computing `minimum(a)` and `maximum(a)`, a being a tuple, and outputing this in a single line.   

##### extrema() - similar to that above 

##### zipppppppp open two tuples and rezip them together like a hoodie: zip(a, b)
If we have two tuples containing an equal number of elements, and we would like
to combine them so that each element at each matching index is now side by
side, we can use the zip() function; `zip((1, 2, 3), (3, 2, 1))` would produce
something like - **3-element Vector{Tuple{Int64, Int64}}:**     
(1, 3)   
(2, 2)   
(3, 1)   

* Rememeber that an array has more information associated with it than simply
it's contents, it also has the index values of the elements within it's
contents, which can be utilized and computed with - but often this index value must be accessed, or even, created, by another function - for example with enumerate.   

##### list out the elements of a tuple with their associated index 
If we have five elements in a tuple, and we want to perform some functions on these elements AND utilize their index values, we can give enumerate a go;  
```
   a = ["a", "b", "c"]   
   for (index, value) in enumerate(a)
           println("$index $value")
       end
```         
1 a   
2 b   
3 c    















