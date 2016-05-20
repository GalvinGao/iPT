--[[

    iPad Performance Tester

        Version: v0.1.7
        Author: Galvin Gao
        Update Time: 2016.5.20 14:57
        GitHub: http://github.com/GalvinGao/iPT


    This program is designed for testing iPad performance.
    
    The principle is the iPad will find the power of pi for 50,000,000 times and measure the time it takes.

    [!] Disclaimer: This program is designed for testing the performance and the author doesn't assume any damage on anything. The test may broken your iPad if you are using it with a big frequence. Please be responsible to your own device.

]]--

supportedOrientations( LANDSCAPE_RIGHT )  

function setup()
    saveProjectInfo( "Description", "This program is designed for testing iPad performance. The principle is the iPad will find the power of pi for 50,000,000 times and measure the time it takes." )
    saveProjectInfo( "Author", "Galvin Gao" )
    testHaveBeenTested = 0
    Enter_Specilified_Time_for_Searching = 0
    parm()
end

function draw()
    background(100, 120, 160, 150)
    font("Futura-MediumItalic")
    fill(255)
    fontSize(20)
    textWrapWidth(500)
    text("This test will make your iPad to find the power of π for 50000000 times.\n\nPlease mind, the test may take a while to run, please be patient.\n\n\nAverage:\n8.657363s", WIDTH/2, HEIGHT/2)
    
end 

----- [Start] Menu area -----

function parm()
    parameter.clear()
    parameter.watch( "testHaveBeenTested" )
    parameter.action( "Test once...", test )
    parameter.action( "...  More Test Options  ...", more_test_menu_parm )
    parameter.action( "---  History  ---", history_menu_parm )
    parameter.action( "|||  Clear Output  |||", clearOutput )
end

function more_test_menu_parm()
    parameter.clear()
    parameter.action( "== Back ==", parm )
    parameter.action( "Start 10x Test", test10times )
    parameter.action( "Start 25x Test", test25times )
    parameter.action( "Start 100x Test", test100times )
end

function history_menu_parm()
    parameter.clear()
    parameter.action( "== Back ==", parm )
    parameter.action( "Read Last Time Result", readLastestResult )
    parameter.integer( "Specilified_Time_to_Search", 1, 100, "" )
    parameter.action( "Read Specilified Time Result", readSpecilifiedResult )
end

function clearOutput()
    output.clear()
end

----- [End] Menu area -----



----- [Start] Test front -----

function testRunningButton()
    parameter.action( "Test is running" )
    parameter.action( "Test is running." )
    parameter.action( "Test is running.." )
    parameter.action( "Test is running..." )
end

----- [End] Test front -----



----- [Start] Test area -----

-- Test 001x

function test()
    parameter.clear()
    parameter.watch( "testHaveBeenTested_TestIsRunning..." )
    testRunningButton()
    passtime = os.clock()
    for i = 1, 50000000 do
        pi = math.pi
        math.sqrt( pi )
    end
    nowtime = os.clock()
    passedtime = nowtime - passtime
    print( passedtime .. " s" )
    testHaveBeenTested = testHaveBeenTested + 1
    saveWithIndex()
    saveLastTime()
    parm()
end

-- Test 010x

function test10times()
    parameter.clear()
    parameter.watch( "testHaveBeenTested_TestIsRunning..." )
    testRunningButton()
    ()
    for i = 1, 10 do
        passtime = os.clock()
            for i = 1, 50000000 do
                pi = math.pi
                math.sqrt( pi )
            end
        nowtime = os.clock()
        passedtime = nowtime - passtime
        print( i.."th test is done. Result: "..passedtime.."s" )
        testHaveBeenTested = testHaveBeenTested + 1
        saveWithIndex()
        saveLastTime()
    end
    parm()
end

-- Test 025x

function test25times()
    parameter.clear()
    parameter.watch( "testHaveBeenTested_TestIsRunning..." )
    testRunningButton()
    ()
    print( "This test will take really a long while. Please be patient." )
    print( "This test will take really a long while. Please be patient." )
    print( "This test will take really a long while. Please be patient." )
    for i = 1, 25 do
        passtime = os.clock()
            for i = 1, 50000000 do
                pi = math.pi
                math.sqrt( pi )
            end
        nowtime = os.clock()
        passedtime = nowtime - passtime
        print( i.."th test is done. Result: "..passedtime.."s" )
        testHaveBeenTested = testHaveBeenTested + 1
        saveWithIndex()
        saveLastTime()
    end
    parm()
end

-- Test 100x

function test100times()
    parameter.clear()
    parameter.watch( "testHaveBeenTested_TestIsRunning..." )
    testRunningButton()
    ()
    print( "This test will take really a long while. Please be patient." )
    print( "This test will take really a long while. Please be patient." )
    print( "This test will take really a long while. Please be patient." )
    for i = 1, 100 do
        passtime = os.clock()
            for i = 1, 50000000 do
                pi = math.pi
                math.sqrt( pi )
            end
        nowtime = os.clock()
        passedtime = nowtime - passtime
        print( i.."th test is done. Result: "..passedtime.."s" )
        testHaveBeenTested = testHaveBeenTested + 1
        saveWithIndex()
        saveLastTime()
    end
    parm()
end

----- [End] Test area -----


    
----- [Start] Data save -----

function saveWithIndex()
    saveLocalData( "result_"..testHaveBeenTested, passedtime )
end

function saveLastTime()
    saveLocalData( "lastTimeResult", passedtime )
end

----- [End] Data save -----



----- [Start] Data read -----

function readLastestResult()
    LTR = readLocalData( "lastTimeResult" )
    print( "Last time result: "..LTR.."s")
end

function readSpecilifiedResult()
    dataKey = "result_"..Specilified_Time_to_Search
    data = readLocalData( dataKey, "Data Not Found!" )
    print( Specilified_Time_to_Search.."th result is: "..data.."s" )
end

----- [End] Data read -----
