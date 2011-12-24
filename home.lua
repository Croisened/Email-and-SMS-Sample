module(..., package.seeall)

--====================================================================--
-- SCENE: [MASTER TEMPLATE]
--====================================================================--

--[[

 - Version: [1.0]
 - Made by: [Fully Croisened, NJR Studios LLC - Nathanial Ryan]
 - Website: [www.fullycroisened.com]
 - Mail: [croisened@gmail.com]

******************
 - INFORMATION
******************

  - [XXXXXXXXXX]
  -Reference...View this post for all the options available to SMS and Email from showPopup
  http://developer.anscamobile.com/reference/index/nativeshowpopup

--]]

new = function ()

	------------------
	-- Imports, Include any external references that this scenes needs
	-- Example: local ui = require ( "ui" )
	------------------
    local ui = require ( "ui" )

	-------------------------------------------------
	-- Handle any Params that get passed to the Scene
	-------------------------------------------------

	local vLabel = ""
	local vReload = false
	local mapURL
	--
	if type( params ) == "table" then
		--
		if type( params.label ) == "string" then
			vLabel = params.label
		end
		--
		if type( params.reload ) == "boolean" then
			vReload = params.reload
		end
		--
	end


	------------------
	-- Groups
	------------------

	local localGroup = display.newGroup()

    ------------------
    -- Local Variable Definitions
    -------------------
	local backGround = display.newImage( "bg.png", true )

	------------------
	-- Functions
	------------------
    local locationHandler = function( event )
    
      if event.errorCode then
		--native.showAlert( "GPS Location Error, feature not available", event.errorMessage, {"OK"} )
		mapURL = "GPS Location Unavailable at this time"
		print( "Location error: " .. tostring( event.errorMessage ) )
	  else
	    local latitudeText = string.format( '%.4f', event.latitude )
	    currentLatitude = latitudeText
	
	    local longitudeText = string.format( '%.4f', event.longitude )
	    currentLongitude = longitudeText
	
        mapURL = "http://maps.google.com/maps?q=YOU+ARE+HERE@" .. tostring(currentLatitude) .. "," .. tostring(currentLongitude)

      end
    end

    -------------------
    --Change Scene-----
    -------------------
    local moveToScene = function(event)

      --NOTE, no scene changes in this example so this is not really needed
      
      --Example scene change with parameters
      --director:changeScene( { label="Scene Reloaded" }, "screen2","moveFromRight" )

      --Example scene change without parameters
      --director:changeScene( "screen1", "crossfade" )

	  --director:changeScene( "screen1", "moveFromLeft" )
	 

    end
    

    --***BLANK EMAIL***
    
    local sendEmail = function(event)
	  native.showPopup("mail")
    end
    
    local mailButton1 = ui.newButton{
    	default = "emailbutton.png",
	    over = "emailbuttonover.png",
	    onRelease = sendEmail,
    }


    --***EMAIL WITH MY LOCATION

    local sendEmail = function(event)
	  native.showPopup("mail",{to=getGlobal("emailTo"), body="My current location: " .. mapURL, subject="Email With My Location"})
    end

    local mailButton2 = ui.newButton{
    	default = "emailbutton2.png",
	    over = "emailbutton2over.png",
	    onRelease = sendEmail,
    }


    --***EMAIL WITH ATTACHMENT
    --We will just email ourselves the background image, but it could be any file you want to attach
    
    local sendEmail = function(event)
	  --native.showPopup("mail",{to=getGlobal("emailTo"), attachment={baseDir=system.DocumentsDirectory, filename="bg.png", type="image"}, body="How cool is this", subject="Email With Attachment"})
	  native.showPopup("mail",
	                   {to=getGlobal("emailTo"), 
	                    cc=nil, 
	                    bcc=nil, 
	                    attachment={baseDir=system.DocumentsDirectory, filename="bg.png", ["type"]="image" },
	                    body="How cool is this?",
	                    isBodyHtml=false,
	                    subject="Email With Attachment"})
    end

    local mailButton3 = ui.newButton{
    	default = "emailbutton3.png",
	    over = "emailbutton3over.png",
	    onRelease = sendEmail,
    }



    
    --***BLANK SMS

    local sendText = function(event)
	 native.showPopup("sms")
    end

    local smsButton1 = ui.newButton{
    	default = "textbutton.png",
	    over = "textbuttonover.png",
	    onRelease = sendText,
    }


    --***SMS With My Location

    local sendTextWithMyLocation = function(event)
	 native.showPopup("sms",{to=getGlobal("phone"), body="My current location: " .. mapURL})
    end

    local smsButton2 = ui.newButton{
    	default = "textbutton2.png",
	    over = "textbutton2over.png",
	    onRelease = sendTextWithMyLocation,
    }


	------------------
	-- Code here
	------------------

	--====================================================================--
	-- INITIALIZE, Every Display Object must get shoved into the local Display Group
	-- Example:	localGroup:insert( background )
	--====================================================================--
	local initVars = function ()

      print("Initializing Home")
	  localGroup:insert(backGround)
	  localGroup:insert(mailButton1)
	  localGroup:insert(mailButton2)
	  localGroup:insert(mailButton3)
	  localGroup:insert(smsButton1)
	  localGroup:insert(smsButton2)


       --Position Things
       mailButton1.x = display.contentWidth / 2
       mailButton1.y = 100

       mailButton2.x = display.contentWidth / 2
       mailButton2.y = 200

       mailButton3.x = display.contentWidth / 2
       mailButton3.y = 300

       smsButton1.x = display.contentWidth / 2
       smsButton1.y = 400

       smsButton2.x = display.contentWidth / 2
       smsButton2.y = 500
       
       -- Activate location listener
       Runtime:addEventListener( "location", locationHandler )

    end



    --Clean up local variables, etc...
	clean = function()
	  print("Cleaning Home")

	end


   	------------------
	-- INITIALIZE variables
	------------------
	initVars()

	------------------
	-- MUST return a display.newGroup()
	------------------
	return localGroup

end
