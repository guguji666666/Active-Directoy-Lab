## Configure scheduled task to run specified program every hour

### Steps to configure domain GPO

![A computer screen shot of a scheduler  Description automatically generated](https://guguimage.aceultraman.com/i/2023/08/14/kna86l-1.jpg) 

![A screenshot of a computer  Description automatically generated](https://guguimage.aceultraman.com/i/2023/08/14/kna7ok-1.jpg) 

In domain GPO it seems the frequency couldn’t be set to 4 hours. 

Local GPO could have 4 hours frequency selected. But we can also set the frequency to daily if you want.

![A screenshot of a computer program  Description automatically generated](https://guguimage.aceultraman.com/i/2023/08/14/kna96m-1.jpg)

 
In Actions, define the path of the program you want to run

![A screenshot of a computer program  Description automatically generated](https://guguimage.aceultraman.com/i/2023/08/14/kna1wd-1.jpg)


Check the box here

![A screenshot of a computer  Description automatically generated](https://guguimage.aceultraman.com/i/2023/08/14/kna9vb-1.jpg) 

Then link the domain GPO to machine objects and run the command `gpupdate /force` on these machines.
