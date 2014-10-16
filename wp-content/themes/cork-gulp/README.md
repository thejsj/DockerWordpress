## Cork Theme (Gulp Version)
#### Description:
-------------------
Cork is a custom, bare-bones WordPress theme designed and managed in an effort to improve workflow and better accommodate local development of WordPress projects. A great deal of the code for this theme has come from HTML5 Boilerplate. This theme has been configured to use Grunt as the task manager required to execute the compilations necessary for building site script and style files. 

Cork is also based on the usage of SASS preprocessing. Furthermore, the theme is structured to allow for a mobile-first development strategy. Backwards compatibility for media queries is achieved by serving a differnt stylesheet to browsers that do not recognize the media query feature of CSS (thank you to Ben Callahan and the guys at SparkBox for this awesome mixin). 

There are a few other nuggets in there that I like to have out of the box such as a positioning mixin that I pulled from Bourbon and a PHP mobile & tablet detection script. 

-------------------
#### Installation: 
-------------------
This theme is intended for local development of projects. I have include a general command-line workflow for project creation and source-control. However, this workflow is not required when using the Cork Theme.

```
cd YourSitesDirectory
mkdir YourProjectDirectory
```

##### Using Gulp:
If you do not have Gulp installed on your machine, you will need to install it globally before getting going. Here is more about [Gulp](https://github.com/gulpjs/gulp/blob/master/docs/getting-started.md).

Once Gulp is installed globally, you now need to run the following commands to make sure a couple of other dependencies have been installed in your project directory. First, there is a dependency on a ruby gem for CSS keyframe animation. To ensure you have this gem installed run the following:
```
gem install animation --pre
```
(note - if you feel like you are not going to be using keyframe animations, you can simply delete the last line of the compass.rb file in the project root)

Next, you will need to install the project dependencies that are listed in the ```package.json``` file using the following command:
```
npm install
```

Finally, you should be able to get your project up and going by running 
```
gulp build
```
For livereload functionality, run ```gulp watch```.

-------------------
#### Usage: 
-------------------
Feel free to use this code at your leisure for any project, commercial or personal, where it might be useful.

-------------------
#### Why Cork?: 
-------------------	
It's at the heart of the [greatest game](http://en.wikipedia.org/wiki/Baseball_\(ball\)) of them all.