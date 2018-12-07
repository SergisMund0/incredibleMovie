# incredibleMovie   <img src="https://github.com/SergisMund0/assets/blob/master/movieIconLarge.png" width="55" height="55">

Application written in Swift and designed using clean architecture. Get popular content from [theMovieDB](https://www.themoviedb.org) and play filtering the content :)

To be sure this project will be running in your laptop, please run "pod install" in order to get all the dependencies.

## Application overview

### Dashboard & Filtering
<img src="https://github.com/SergisMund0/assets/blob/master/movieDashboard.png" width="400" height="700"><img src="https://github.com/SergisMund0/assets/blob/master/movieFilter.png" width="400" height="700">

Once the application loads, you are redirected to the dashboard. In this scene you can easily apply a filter over the existing content
or you can just retrieve more movies just scrolling down. The application has infinite scrolling.

You can hide and show the filter view pressing within the filter button then you can apply a range using the slider.

Note: If you have applied a filter previously and you do scroll down, the server will respond with the next movies
but you will see the content filtered respecting the filter applied before. 

Play with the filter component and see how the content reloads locally. :smiley:

### Detail & Error State
<img src="https://github.com/SergisMund0/assets/blob/master/movieDetailStar.png" width="400" height="700"><img src="https://github.com/SergisMund0/assets/blob/master/movieError.png" width="400" height="700">

You can access to the overview description clicking within one content. 

If there is no internet connection or a problem when the application asks for content to the server, a 
modal scene will be presented with the description of the error.

## Architecture and implementation details

The application is written in Swift and designed using VIPER architecture. The functionality is divided in different scenes:

- Dashboard scene

Represents the core of the application. Here is where you can see the popular content and apply filters.

- Detail scene

Show the detail for a given content.

- Error scene

This scene is shown when a Network error is fired.

## Third party libraries

- Alamofire & AlamofireImage https://github.com/Alamofire/Alamofire
- RangeSeekSlider https://github.com/WorldDownTown/RangeSeekSlider
- lottie-ios https://github.com/airbnb/lottie-ios

## Support & contact

You can contact me via e-mail: sergio.garrer@gmail.com
