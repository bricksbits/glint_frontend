## Tasks :

# Events 
- For Users fetching Event Cards, there is missing location Name needed to fix it, remove the static 3 profile rows and make it only see profiles 
- For Admin when tracking particular Event, Update the Location Label 
- For All user type in the Event Details Screen we wanted to showcase the Maps URL link in the Preview as we are doing in the Confirm ticket screen.
- Whenever some Clicks on the Explore Tab and click on any List Item, show a Snackbar showing that static categories will be available soon.
- Fix the long text at each screen, [Chat, PeopleCard, Event, AdminCard, Ticket History, Payment History] Where ever we are showing the data, not filling it.

# Tasks : Improve permission Handling of the entire app 
We take two permissions from our Users, 
1. Location 
2. Notification 

While onboarding as User ( primary customer ) we ask their permission consent, The Location Permission btn works fine 
- Showing state like Enabling, Make it enable 

I wanted something similar for the Notification permission as well, 
Generally when the Location permission is provided even without the Notification permission the app move forward to other screen, 
I want scenarios where once the user have either accepted or rejected any of the 2 permissions they can enter the app, 
Or press the `procced anyway` btn 

Also in few old devices, once the user is trying to provide the location permission it take the app lot of time to collect it and register as granted or rejected, 
Can anything we can do here to improve it? 

Also if you in the Home Screen whenever the user comes back to the App from Background to Foreground we ask for the Permissions again, 
I want changes in this behaviour, the asking of the permission should only be done if the permission are rejected or not provided, 
Also should be called when entering the Home Screen 

You can have a look at those files 
: 