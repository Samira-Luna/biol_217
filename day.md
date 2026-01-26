# Markdown tipps for protocol
Always name your files ending with `.md` for it to work!

# Day 1 

## Basic commands
```
cd: Change directory 
ls: List files and directories
mkdir: Make a directory 
rm: Remove file 
rm -r: Remove directory 
cp: Copy file or directory
touch: Create new empty file
cat: concatenate and display
echo: output textto screen
```

### Use of terminal 
Start session
```
ssh -X sunam233@caucluster.rz.uni.kiel-kiel.de
```
Enter password: biol217_2026&&

Always go to work directory 
```
cd $WORK
```
# Line breaks
If you want some text to start in the next line, a ENTER is not enough.

Use two Enters, <br>
or instert \<br> where needed.

# Create a list
1.
2.
3.

# Create bulletpoints
* 
* 
1. also combinable
    * with numbers

# Highlight text options
* Highlighting `the text`
* Making the *text* italic
* Making the **text** bold
* Making the ***text*** italic & bold
* Underlining the <u>text</u> 


# Documenting code
Use \``` to highlight your code in  blocks
```
print("Hello World")
```
# Including links 
Type work you want to be hyperlinked in [] and the link beind in ()

[FastQC](https://github.com/s-andrews/FastQC)


# Create a table  (use pipes \|)
 ### Tools used:
| Tool | Version | Repository |
| --- | --- | --- |
| fastqc | 0.11.9 | [FastQC](https://github.com/s-andrews/FastQC ) |
| fastp | 0.22.0 | [fastp](https://github.com/OpenGene/fastp ) |
| megahit | 1.2.9 | [megahit](https://github.com/voutcn/megahit ) |


# Include pictures
* Create a folder called "images" in your repo
* place the image inside it

![image](./images/your_image.png)