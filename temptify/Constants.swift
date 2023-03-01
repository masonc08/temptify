//
//  Constants.swift
//  temptify
//
//  Created by mason on 2023-03-01.
//

import Foundation


struct Constants {
    static let helpPageText = "We will help you get better at resisting notifications from your most distracting apps so you can be your most productive self!\n\nHere’s how it’ll happen:\n\n1. Tell us which apps you’re resisting.\n2. We will block all notifications for these apps for you, please don’t manually unblock them.\n3. You’ll receive notifications from us periodically asking is you want to open your distracting apps - do your best to resist !\n4. View your ability to resist notifications daily and over time. We will be challenging you to continually improve!\n\nRemember, don’t unblock your notifications or manually open your app(s). Let’s start training your self-control muscles."

    static let feedbackPageText = "We’d like to know if our app is working for you. Tell us some information in the Google Form below to help us make the app better!"
    static let feedbackPageLink = "shorturl.at/diyR9"

    static let facts = [
        "47% of Americans admit they’re addicted to their phones",
        "The average American checks their smartphone 352 times per day",
        "71% of people spend more time on their phone than with their romantic partner",
        "72% of parents feel their teenagers are distracted by smartphones during in-person conversations",
        "44% of American adults admit that not having their phones gives them anxiety",
        "42% of American adults say they waste too much time on their smartphones",
        "30% of Americans say they’d be more productive without their smartphones",
        "People with smartphone addiction have worse sleep quality than those without",
        "Smartphone addiction correlates with anxiety, depression, and other mental health issues",
        "Cell phones cause over 20% of car accidents",
        "Teenagers who spend 5 hours a day on electronic devices are 71% more likely to have suicide risk factors than those with one-hour use.",
        "Smartphone use and depression are correlated.",
        "Being constantly interrupted by alerts and notifications may be contributing towards a problematic deficit of attention.",
        "33% of teens spend more time socializing with close friends online, rather than face-to-face."
    ]
    
    static let notificationsContent: [String: [[String: String]]] = [
        "Instagram": [
            [
                "title": "Trending on Instagram",
                "message": "Ready to explore the latest Reels? Open Instagram now and see what's trending!"
            ],
            [
                "title": "New Instagram Stories",
                "message": "Your favorite accounts just posted new Stories. Don't miss out, tap to view now!"
            ],
            [
                "title": "Discover New Content on Instagram",
                "message": "Discover new accounts and content tailored to your interests. Open Instagram to start exploring!"
            ],
            [
                "title": "Don't Miss Out on Instagram",
                "message": "You haven't been on Instagram for a while. Catch up on what you've missed and discover new content!"
            ],
            [
                "title": "Discover New Products on Instagram",
                "message": "Find new products and brands on Instagram. Open the app to see what's new!"
            ],
            [
                "title": "Discover New Creators on Instagram",
                "message": "Follow new creators on Instagram and explore fresh content! Check out your suggestions to get started."
            ],
            [
                "title": "Stay Up-to-Date on Instagram Trends",
                "message": "Explore the latest Instagram trends and stay in the loop. Tap to discover what's hot right now."
            ],
            [
                "title": "Celebrate with Your Instagram Community",
                "message": "It's a special occasion! Share your celebrations with your Instagram community and spread the joy. Post a story now!"
            ],
            [
                "title": "Get Inspired by Instagram Creativity",
                "message": "See the world through different lenses and get inspired by Instagram creativity. Open the app to check out some of our favorite accounts."
            ],
            [
                "title": "Don't Miss Out on Instagram Stories",
                "message": "Catch up on Instagram Stories from your favorite creators. Swipe up to view them now!"
            ]
        ],
        "Facebook": [
            [
                "title": "New Group Discussion on Facebook",
                "message": "Your favorite group just posted a new discussion. Join the conversation now!"
            ],
            [
                "title": "Local Events on Facebook",
                "message": "Looking for something to do this weekend? Check out the latest events in your area on Facebook!"
            ],
            [
                "title": "Great Deals on Marketplace on Facebook",
                "message": "Find great deals on things you love. Open Facebook Marketplace to browse and buy now!"
            ],
            [
                "title": "Stay Connected on Facebook",
                "message": "Keep in touch with friends and family on Facebook. Check out your News Feed to see what everyone's up to!"
            ],
            [
                "title": "Join a New Group on Facebook",
                "message": "Discover new communities and connect with like-minded people. Join a new group on Facebook now!"
            ],
            [
                "title": "Share Your Thoughts on Facebook",
                "message": "Join the conversation and share your thoughts with friends and family on Facebook. Start a discussion now!"
            ],
            [
                "title": "Connect with Family on Facebook",
                "message": "Stay connected with your family members on Facebook, no matter where you are. Check in with your loved ones now!"
            ],
            [
                "title": "Find Support on Facebook",
                "message": "Join a support group on Facebook to connect with others who share your experiences. Find a community of support now!"
            ]
        ],
        "TikTok": [
            [
                "title": "Trending on TikTok",
                "message": "Discover what's trending on TikTok. Open the app to see the latest videos and challenges!"
            ],
            [
                "title": "New Creator Content on TikTok",
                "message": "Your favorite creators just posted new content. Tap to watch and be entertained!"
            ],
            [
                "title": "Discover New Music on TikTok",
                "message": "Explore new music and artists on TikTok. Open the app to listen and discover now!"
            ],
            [
                "title": "Get Inspired on TikTok",
                "message": "Get inspired by new ideas and creativity on TikTok. Open the app to see what's trending!"
            ],
            [
                "title": "Try a New Challenge on TikTok",
                "message": "Join the fun and try a new challenge on TikTok. Tap to watch and participate now!"
            ],
            [
              "title": "Get Creative on TikTok",
              "message": "It's time to show off your creativity! Make a new video on TikTok and let your imagination run wild."
            ],
            [
              "title": "Join a Challenge on TikTok",
              "message": "Challenge yourself and join a new trend on TikTok. See what challenges are going viral and get in on the action."
            ],
            [
              "title": "Watch Funny Videos on TikTok",
              "message": "Need a laugh? Check out some hilarious videos on TikTok and brighten up your day."
            ]
        ],
        "Twitter": [
            [
                "title": "Stay Up to Date on Twitter",
                "message": "Stay up to date with the latest news and trends. Check out the latest Moments on Twitter!"
            ],
            [
                "title": "Create Custom Lists on Twitter",
                "message": "Create custom lists to keep track of your favorite accounts and topics. Open Twitter to get started!"
            ],
            [
                "title": "Join the Conversation on Twitter",
                "message": "Join the conversation and explore new topics on Twitter. Open the app to start tweeting now!"
            ],
            [
                "title": "Discover New Voices on Twitter",
                "message": "Discover new perspectives and voices on Twitter. Follow new accounts to see what's out there!"
            ],
            [
                "title": "Engage with Your Audience on Twitter",
                "message": "Interact with your audience and build your brand on Twitter. Open the app to start engaging now!"
            ],
            [
                "title": "Discover New Features on Twitter",
                "message": "Twitter constantly introduces new features to improve your experience. Stay up to date with the latest updates!"
            ],
            [
                "title": "Connect with Your Audience on Twitter",
                "message": "Engage with your followers and build your community on Twitter. Open the app to start connecting now!"
            ]
        ],
        "WhatsApp": [
            [
                "title": "Stay Connected with Friends and Family on WhatsApp",
                "message": "Keep in touch with your loved ones on WhatsApp. Send a message to say hello today!"
            ],
            [
                "title": "Create Groups on WhatsApp",
                "message": "Create a group chat on WhatsApp to stay connected with your family, friends, or colleagues. Open the app to get started!"
            ],
            [
                "title": "Send Voice Messages on WhatsApp",
                "message": "Record and send voice messages on WhatsApp to communicate more easily. Try it out now!"
            ],
            [
                "title": "Discover New Stickers on WhatsApp",
                "message": "Make your chats more fun with new stickers on WhatsApp. Check out our latest collections!"
            ],
            [
                "title": "Discover Fun and Interesting Groups",
                "message": "Join exciting groups on WhatsApp to connect with like-minded people and explore new topics."
            ],
            [
                "title": "Share Photos and Videos with Ease",
                "message": "Quickly and easily share photos, videos, and messages with your contacts on WhatsApp."
            ],
            [
                "title": "Make Voice and Video Calls",
                "message": "Stay in touch with your friends and family no matter where you are with voice and video calls on WhatsApp."
            ],
            [
                "title": "Set Custom Wallpapers for Chats",
                "message": "Personalize your chats by setting custom wallpapers for individual chats or all of them on WhatsApp."
            ],
            [ "title": "Create and Share Animated Stickers",
              "message": "Express yourself with fun and animated stickers on WhatsApp. Create your own and share them with friends!"
            ],
        ],
        "Snapchat": [
            [
                "title": "Snap Your Day with Snapchat",
                "message": "Share your day with your friends on Snapchat. Snap a photo or record a video now!"
            ],
            [
                "title": "Discover New Lenses on Snapchat",
                "message": "Add some fun to your snaps with new lenses on Snapchat. Try them out now!"
            ],
            [
                "title": "Chat with Friends on Snapchat",
                "message": "Chat with your friends on Snapchat to stay connected. Send a message or start a video call now!"
            ],
            [
                "title": "Follow Celebrities on Snapchat",
                "message": "Follow your favorite celebrities on Snapchat to see what they're up to. Find new accounts to follow now!"
            ],
            [
                "title": "Explore Discover on Snapchat",
                "message": "Discover new content and stories on Snapchat. Swipe left to start exploring!"
            ],
            [
                "title": "Don't Miss Out on Snapchat",
                "message": "You haven't used Snapchat in a while. Check out your friends' Stories and send a Snap to stay connected!"
            ],
            [
                "title": "Snapchat Streaks",
                "message": "Don't lose your streaks! Keep snapping with your friends on Snapchat to maintain your streaks."
            ],
            [
                "title": "Snapchat Discover",
                "message": "Stay up to date with the latest news, entertainment, and trends on Snapchat Discover."
            ],
        ],
        "WeChat": [
            [
                "title": "Moments on WeChat",
                "message": "Check out your friends' Moments on WeChat and see what they've been up to!"
            ],
            [
                "title": "Stay Connected with Friends on WeChat",
                "message": "Catch up with friends and family on WeChat. See what's new with your contacts!"
            ],
            [
                "title": "Discover New Groups on WeChat",
                "message": "Find new communities and join discussions on WeChat. Explore the groups section now!"
            ],
            [
                "title": "Get Daily News on WeChat",
                "message": "Stay informed with the latest news and trends on WeChat. Follow official accounts to get updates!"
            ],
            [
                "title": "Explore Moments on WeChat",
                "message": "Discover new content and share your life with friends on WeChat Moments. Open the app now!"
            ],
            [
                "title": "Send Stickers and Emojis on WeChat",
                "message": "Express yourself with stickers and emojis on WeChat. Try out the latest ones today!"
            ]
        ],
        "Gmail": [
            [
                "title": "Discover new features on Gmail",
                "message": "Explore the latest features and settings on Gmail. Make your email experience more efficient!"
            ],
            [
                "title": "Stay organized with Gmail labels",
                "message": "Keep your inbox clean and organized with Gmail labels. Sort your emails and find what you need quickly!"
            ],
            [
                "title": "Customize your Gmail signature",
                "message": "Personalize your email communications with a customized Gmail signature. Make a great impression!"
            ],
            [
                "title": "Set up filters and rules on Gmail",
                "message": "Make your email experience more streamlined by setting up filters and rules on Gmail. Save time and reduce clutter!"
            ],
            [
                "title": "Weekly summary with Gmail",
                "message": "Get a weekly summary of your Gmail activity. Check out what you missed and stay on top of your inbox!"
            ],
            [
                "title": "Promotions in Gmail",
                "message": "Check out the latest promotions and deals in your Promotions tab in Gmail!"
            ],
            [
                "title": "Organize your inbox in Gmail",
                "message": "Your inbox could use some organizing! Try using labels and filters to keep your messages tidy."
            ],
            [
                "title": "Increase productivity with Gmail",
                "message": "Boost your productivity with these Gmail shortcuts. Open the app to learn more!"
            ]
        ],
        "Outlook": [
            [
                "title": "Stay Productive with Outlook",
                "message": "Organize your day and stay on top of your tasks with Outlook. Check your calendar and to-do list to make the most of your time!"
            ],
            [
                "title": "Connect with Colleagues on Outlook",
                "message": "Stay connected with your colleagues and clients on Outlook. Send messages, schedule meetings, and collaborate on projects all in one place!"
            ],
            [
                "title": "Get Noticed with Outlook",
                "message": "Make your emails stand out with Outlook's rich formatting and design features. Grab your recipient's attention and make a lasting impression!"
            ],
            [
                "title": "Manage Your Inbox with Outlook",
                "message": "Take control of your inbox with Outlook's powerful filtering and organization tools. Keep important messages at the top and stay on top of your workload!"
            ],
            [
                "title": "Stay on Schedule with Outlook",
                "message": "Never miss a deadline or meeting with Outlook's reminders and scheduling features. Stay on schedule and impress your boss and colleagues!"
            ],
            [
                "title": "Get Organized with Outlook",
                "message": "Use Outlook to keep your life organized. Use features like folders, labels, and rules to manage your inbox and stay on top of important tasks."
            ]
        ],
        "Reddit": [
            [
                "title": "Stay Up-to-Date on Reddit",
                "message": "Don't miss out on the latest posts and discussions on Reddit. Open the app to stay up-to-date!"
            ],
            [
                "title": "Discover New Communities on Reddit",
                "message": "Find new subreddits and communities to explore on Reddit. Tap to see what's trending now!"
            ],
            [
                "title": "Join the Conversation on Reddit",
                "message": "Engage with other Reddit users and share your thoughts on trending topics. Open the app to join the conversation!"
            ],
            [
                "title": "Get Inspired on Reddit",
                "message": "Find inspiration and creativity on Reddit. Explore new content and ideas now!"
            ],
            [
                "title": "Upvote Your Favorite Posts on Reddit",
                "message": "Show your support for your favorite posts on Reddit. Upvote now and let your voice be heard!"
            ],
            [
                "title": "Find Your Community on Reddit",
                "message": "Join a subreddit that matches your interests and engage with like-minded people. Discover new topics and expand your horizons!"
            ],
            [
                "title": "Stay Informed with Reddit",
                "message": "Get the latest news, trends, and opinions from around the world on Reddit. Follow subreddits to stay up-to-date on what matters to you."
            ],
            [
                "title": "Explore New Perspectives on Reddit",
                "message": "Challenge your beliefs and expand your worldview on Reddit. Discover new perspectives and engage in meaningful conversations with people from all walks of life."
            ],
            [
                "title": "Get Inspired on Reddit",
                "message": "Find motivation, inspiration, and creativity on Reddit. Discover new ideas and perspectives to help you achieve your goals."
            ],
            [ "title": "Discover Hidden Gems on Reddit",
              "message": "Find the best of the internet on Reddit. Discover new websites, products, and services that you might never have heard of otherwise."
            ]
        ]
    ]





}
