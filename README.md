# Requirements

Make sure you have  `bundler` and  `ruby '2.3.1'`.
# Getting Started

For safety reasons one should store Keys and Secrets in environment variables. Export your keys and secrets by typing on your terminal:
* `export CONSUMER_KEY="<YOUR_CONSUMER_KEY>"`
* `export CONSUMER_SECRET="<YOUR_CONSUMER_SECRET>"`
* `export ACCESS_TOKEN="<ACCESS_TOKEN>"`
* `export ACCESS_SECRET="<YOUR_ACCESS_SECRET>"`
* `export FLICKR_API_KEY="<FLICKR_API_KEY>"`
* `export FLICKR_SECRET_CODE="<FLICKR_SECRET_CODE>"`

Once inside the folder run:
`bundle install`

To get the pictures from the Twitter API run in your terminal:

`ruby twitter_runner.rb`

To get the pictures from the Flickr API run:

`ruby flickr_runner.rb`

### Flickr #dctech tag

As of today, there is no photo within the last month with the tag `#dctech`. I change the search to look for images with the tag starting January 2017 to February 2018 in order for me to show you results. If you would like to change the date to be the last month. In the flickr_runner.rb file change the parameter `min_upload_date:` in the get photos method from `'2017-01'` to `'2018-01'`. You can even add the day, according to the Flickr API documentation the dates use `mysql` format for the dates.

# Overview

While working on this project I tried to manage dependencies as much as possible by following Object Oriented Design principles. I built single responsibility methods, used classes and instances of classes in order to manage the functionality of this application. At first, I thought of using Ruby on Rails for this project but I think I made the right choice by building a Ruby command line application. A rails application would have been a wrong choice, with extra functionality I don't really need.

# Twitter API

There were some issues while fetching data from the Twitter API. First, even after passing the right arguments to the `.search` method the return results would have objects without some of the data. For example, results would have tweets without the specific hashtag specified or without any media at all.

That is one of the reasons why unlike the Flickr API I decided to create a class `TweetConverter` that would help me after getting the results to get rid of the tweets that didn't meet the criteria described in the directions of this project. According to the Twitter API documentation, these parameters would have worked in a premium plan.

At first, I worried I was over-engineering the application but at the end, I decided to go with the extra class since I felt it was necessary to deal with the issue of the search method returning results that didn't meet the criteria given.

# Optimization

While working on raking the photos I wanted to find the most optimized way to do so. With the use of `benchmark`, I believe I was able to choose the most optimal way to rank the photos using `sort_by` method.

At first, I thought about using `.sort` and `.reverse` methods but as the benchmark test would show `sort_by` was the fastest option.

Results:
![alt text](https://pbs.twimg.com/media/DV2pKOeUQAAhcrc.jpg:large)

# Flickr API

Unlike the Twitter API, the Flickr API search method returns all the objects that met the criteria passed as arguments in the search method. In order to deal with the order dependency I set the arguments to be a hash as shown in the following method:

```def get_photos(args={})
  @photos = @flickr.photos.search(args)
end```

Also, the Flickr search method returns a results objects. Each photo in the search results missed some of the data such as the image URL, the number of comments needed to rank them and the tags needed to filter the photos based on the tag "#dctech".

After reading the Flickr API documentation I was able to get these data by adding a field `extras:` to which I passed a string with the data I needed to fetch as follows:
`"count_comments,tags, url_m"`
