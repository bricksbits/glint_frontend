## Tasks :

# Events 
- For Users fetching Event Cards, there is missing location Name needed to fix it, remove the static 3 profile rows and make it only see profiles 
- For fetching the Interested User, apply the pagination with offset as 20 
- For Admin when tracking particular Event, Update the Location 
- For All user type in the Event Details Screen we wanted to showcase the Maps URL link in the Preview as we are doing in the Confirm ticket screen.
- Whenever some Clicks on the Explore Tab and click on any List Item, show a Snackbar showing that static categories will be available soon.


# Notifications 
- As Notifications are working perfectly, I wanted to make certain improvements here 
1. The Logo of the app should be visible at compress rate, ask me for the logo Its here : lib/assets/icons/glint_logo.svg
2. And When I tap on the Notifications, I am getting missing BlocProvider as the Root entrance, What we can do here? For example if I get a Match, its says that ChatCubit is missing, 
   a.I just can initialize all the Cubit at the Root, this will make the initialization time stretch and unnecessary API calls, 
   b.What if We do step wise steps, We first Open Home and then the Chat Cubit? 
   c.This approach is only for the sub routes, for independent routes we are good? 


## Tasks : Update the metadata btw two User in Stream DB for a specific channel, 
My app have a mechanism where whenever a match happens a Stream Channel ID Atomic is being created btw those two users, 
And as a Channel is created the Channel Id is popped up in the Message View 
And user can always enter the chat pressing that Channel respectively, 

Here is a twist, I have two kind of channels that I wanted to maintain, First user who matched normally, where the meta data is as low as current infra, 
But there are channels where the Members are connected via Event Details, 
So if you review the ChatWithScreen, if enter through the RecentMatches List Tap, We get the required arguments and the TicketGradient View is visible, 
but if not that done in this way and the Stream Channel from MessageView is clicked th Event Details are missing, 

We wanted to have a central Global solution to fix this issue, 
Because there can be possibilities that user never touch the Recent Matches List item if there is already a Stream Channel btw two user exists, 

Can we have a pushing meta data btw channels in Stream while fetching the Recent Matches? And Set it to the Stream Server 
And take those values from the Server and show in the ChatWithScreen, so that user enter the ChatScreen from anywhere the data remains constant? 
And the Behaviour remains consistent? 

