--[[

    iPad Performance Tester - Main

        Author: Galvin Gao
        GitHub: https://github.com/GalvinGao/iPT


    This program is designed for testing iPad performance.
    
    The principle is the iPad will find the power of pi for 50,000,000 times and measure the time it takes.

    [!] Disclaimer: This program is designed for testing the performance and the author doesn't assume any damage on anything. The test may broken your iPad if you are using it with a big frequence. Please be responsible to your own device.

]]--

supportedOrientations( LANDSCAPE_ANY )
displayMode( FULLSCREEN_NO_BUTTONS )

-- To test a script
function TestFunction()
    -- Input the script that needs to test
end

-- Run once when start program
function setup()
    -- Save Project Info
    saveProjectInfo( "Description", "This program is designed for testing iPad performance. The principle is the iPad will find the power of pi for 50,000,000 times and measure the time it takes." )
    saveProjectInfo( "Author", "Galvin Gao" )
    
    -- Setup Variable
    setupVar()
    
    -- Menu Setup - Parameter
    parm()
    
    -- Print out MOTD
    motd()
    
    firstRun()
end

function setupVar()
    -- Setup Section Test Counter
    SectionTestCounter = 0
    
    -- Setup Searching Enter Box
    Enter_Specilified_Time_for_Searching = 0
    
    -- Setup FPS Calculate materials - FramesPassed
    fP = 0
    
    -- Setup FPS Calculate materials - LastTime (ElapsedTimeNeedToMinus)
    LT = 0
    
    -- Setup Global Test Counter
    GlobalTestCounter = 0
    
    -- Setup Test Counter Vars
    SaveTimeGC = 0
    LastTimeGC = 0
    
    SaveTimeGT = 0
    LastTimeGT = 0
    
    SaveTimeTA = 0
    LastTimeTA = 0
    
    SaveTimeTT = 0
    LastTimeTT = 0
    
    -- Setup current displayMode
    DisplayMode = "FULLSCREEN_NO_BUTTONS"
    
    NormalTestAvg = 0
    
    -- A function that uses to test a script
    TestFunction()
end

function firstRun()
    isFirstRun = 0
    firstRunRead = readLocalData( "firstRun" )
    if firstRunRead == nil then
        isFirstRun = 1
        else
        isFirstRun = 0
    end
    if isFirstRun == 1 then
        print( "Project storage didn't detected, restoring storage structure..." )
        saveLocalData( "GlobalCounter", 0 )
        saveLocalData( "GlobalTime", 0 )
        saveLocalData( "TestAll", 0 )
        saveLocalData( "TestTimes", 0 )
        saveLocalData( "lastTimeResult", 0 )
        for i = 1, 100 do
            saveLocalData( "result_"..i, 0 )
            saveLocalData( "devide_"..i, 0 )
        end
        saveLocalData( "firstRun", 0 )
        else
        print( "Not first run, do not need to restore structure." )
    end
end

function draw()
    -- FPS Calculation
    fP = fP + 1
    t = ElapsedTime - LT
    fps = fP / t
    if fP > 60 then
        fP = 0
        t = t - LT
        fps = fP / t
        LT = ElapsedTime
        else
    end
    
    -- Setup Background & font properties
    fill( 255 )
    textWrapWidth( 500 )
    sprite("Documents:bkgd", WIDTH/2, HEIGHT/2 )
    
    -- Refresh Avg Value
    ReadNormalTestAvg()
    
    -- Text Editing
    Description = "This test will make your iPad to find the power of π for 50000000 times.\n\nPlease notice, the test may take a while to run, please be patient.\n\n\nAverage:\n" .. NormalTestAvg .. "s"
    Tips = "[ Click once to show/hide menu ]"
    
    -- Shows the description
    fontSize( 20 )
    font( "Futura-MediumItalic" )
    text( Description, WIDTH/2, HEIGHT/2-HEIGHT/12 )
    
    fontSize( 24 )
    font("Futura-Medium")
    text( Tips, WIDTH/2, HEIGHT/2+HEIGHT/4+HEIGHT/12 )
    
    -- Shows the FPS
    fontSize( 11 )
    font( "CourierNewPS-BoldMT" )
    text( "FPS: "..fps, WIDTH/2+WIDTH/4, HEIGHT/2+HEIGHT/8 )
end

-- Display Mode Switcher

function touched(touch)
    if DisplayMode == "FULLSCREEN_NO_BUTTONS" and touch.tapCount == 1 and touch.state == ENDED then
        displayMode( OVERLAY )
        DisplayMode = "OVERLAY"
    elseif DisplayMode == "OVERLAY" and touch.tapCount == 1 and touch.state == ENDED then
        displayMode( FULLSCREEN_NO_BUTTONS )
        DisplayMode = "FULLSCREEN_NO_BUTTONS"
    end
end

-- Print out MOTD
function motd()
    motd = readText( "Documents:motd" )
    if motd == nil then
        print( "MOTD file can not being found..." )
        else
        print( motd )
    end
end

----- [Start] Menu area -----

-- Menu

function parm()
    parameter.clear()
    parameter.watch( "fps" )
    parameter.action( "Quick Test...", test )
    parameter.action( "...  More Test Options  ...", more_test_menu_parm )
    parameter.action( "+++ Test Counter +++", test_counter_parm )
    parameter.action( "---  History  ---", history_menu_parm )
    parameter.action( "|||  Clear Output  |||", clearOutput )
end

-- More Test Menu

function more_test_menu_parm()
    parameter.clear()
    parameter.action( "== Back ==", parm )
    parameter.action( "Start 10x Test", test10times )
    parameter.action( "Start 25x Test", test25times )
    parameter.action( "Start 100x Test", test100times )
    parameter.action( "Custom test...", customtest_prepare )
end

-- History Menu

function history_menu_parm()
    parameter.clear()
    parameter.action( "== Back ==", parm )
    parameter.action( "Read Last Time Result", readLastestResult )
    parameter.integer( "Specilified_Time_to_Search", 1, 100, "" )
    parameter.action( "Read Specilified Time Result", readSpecilifiedResult )
    parameter.action( "Clear all result", clearAllResult )
end

-- Test Counter Menu

function test_counter_parm()
    ReadGlobalCounter()
    ReadGlobalTime()
    ReadNormalTestAvg()
    parameter.clear()
    parameter.action( "== Back ==", parm )
    parameter.watch( "SectionTestCounter" )
    parameter.watch( "NormalTestAvg" )
    parameter.watch( "GlobalTestCounter" )
    parameter.watch( "GlobalTimeUsed" )
end

-- Test Counter Menu - Global Counter Reader

function ReadGlobalCounter()
    GlobalTestCounter = readLocalData( "GlobalCounter" )
end

-- Test Counter Menu - Global Counter Saver

function SaveGlobalCounter()
    LastTimeGC = readLocalData( "GlobalCounter" )
    SaveTimeGC = LastTimeGC + 1
    saveLocalData( "GlobalCounter", SaveTimeGC )
    LastTimeGC = 0
    SaveTimeGC = 0
end

-- Test Counter Menu - Global Time Used Reader

function ReadGlobalTime()
    GlobalTimeData = readLocalData( "GlobalTime" )
    GlobalTimeUsed = GlobalTimeData .. "s"
end

-- Test Counter Menu - Global Time Used Saver

function SaveGlobalTime()
    LastTimeGT = readLocalData( "GlobalTime" )
    SaveTimeGT = LastTimeGT + passedtime
    saveLocalData( "GlobalTime", SaveTimeGT )
    LastTimeGT = 0
    SaveTimeGT = 0
end

-- Test Counter Menu - Normal Test Avg Reader

function ReadNormalTestAvg()
    TestAll = readLocalData( "TestAll" )
    TestTimes = readLocalData( "TestTimes" )
    NormalTestAvg = TestAll / TestTimes
end

-- Test Counter Menu - Normal Test Avg Saver

function SaveNormalTestAvg()
    -- Test Time Used
    LastTimeTA = readLocalData( "TestAll" )
    SaveTimeTA = LastTimeTA + passedtime
    saveLocalData( "TestAll", SaveTimeTA )
    LastTimeTA = 0
    SaveTimeTA = 0
    
    -- Test Times
    LastTimeTT = readLocalData( "TestTimes" )
    SaveTimeTT = LastTimeTT + 1
    saveLocalData( "TestTimes", SaveTimeTT )
    LastTimeTT = 0
    SaveTimeTT = 0
end

-- Clear Output

function clearOutput()
    output.clear()
end

----- [End] Menu area -----



----- [Start] Test front -----

-- Test Running Replace Button

function testRunningButton()
    parameter.clear()
    parameter.action( "Test is running..." )
    parameter.action( "--------------------------------------------" )
    parameter.action( "Please be patient, the test " )
    parameter.action( "may take a while to run." )
end

function CancelTest()
    close()
end

----- [End] Test front -----



----- [Start] Test area -----

-- Test 1 Time

function test()
    testRunningButton()
    passtime = os.clock()
    for i = 1, 50000000 do
        pi = math.pi
        math.sqrt( pi )
    end
    nowtime = os.clock()
    passedtime = nowtime - passtime
    print( "Result: " .. passedtime .. " s" )
    SectionTestCounter = SectionTestCounter + 1
    saveWithIndex()
    saveLastTime()
    SaveNormalTestAvg()
    parm()
end

-- Test 10 Times

function test10times()
    testRunningButton()
    for i = 1, 10 do
        passtime = os.clock()
            for i = 1, 50000000 do
                pi = math.pi
                math.sqrt( pi )
            end
        nowtime = os.clock()
        passedtime = nowtime - passtime
        print( i.."th test is done.\nResult: "..passedtime.."s" )
        SectionTestCounter = SectionTestCounter + 1
        saveWithIndex()
        saveLastTime()
        SaveNormalTestAvg()
    end
    parm()
end

-- Test 25 Times

function test25times()
    testRunningButton()
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
        print( i.."th test is done.\nResult: "..passedtime.."s" )
        SectionTestCounter = SectionTestCounter + 1
        saveWithIndex()
        saveLastTime()
        SaveNormalTestAvg()
    end
    parm()
end

-- Test 100 Times

function test100times()
    testRunningButton()
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
        print( i.."th test is done.\nResult: "..passedtime.."s" )
        SectionTestCounter = SectionTestCounter + 1
        saveWithIndex()
        saveLastTime()
        SaveNormalTestAvg() 
    end
    parm()
end

-- Custom test - Preparation / Setup & Ask for input

function customtest_prepare()
    parameter.clear()
    testRunningTimes = 0
    parameter.action( "== Back ==", more_test_menu_parm )
    parameter.integer( "testRunningTimes", 1, 100, 1 )
    parameter.integer( "testHowManyTimesDividePi_timed1000000", 1, 100, 50, customtest_dividetimes )
    parameter.watch( "testHowManyTimesDividePi" )
    parameter.action( "Submit", customtest_check )
end

-- Custom test - Divide times calculation & Variable set

function customtest_dividetimes()
    testHowManyTimesDividePi = testHowManyTimesDividePi_timed1000000 * 1000000
end

-- Custom test - Value Check

function customtest_check()
    if testRunningTimes == 0 or testRunningTimes == 1 then
        parameter.clear()
        parameter.action( "== Back ==", customtest_prepare )
        parameter.action( "Illegal input!" )
    else
        customtest()
    end
end

-- Custom test

function customtest()
    testRunningButton()
    for i = 1, testRunningTimes do
        passtime = os.clock()
            for i = 1, testHowManyTimesDividePi do
                pi = math.pi
                math.sqrt( pi )
            end
        nowtime = os.clock()
        passedtime = nowtime - passtime
        print( i.."th test is done.\nResult: "..passedtime.."s" )
        SectionTestCounter = SectionTestCounter + 1
        saveWithIndex()
        saveLastTime()
        if testHowManyTimesDividePi == 50000000 then
            ReadNormalTestAvg()
        else
        end
    end
    parm()
end

----- [End] Test area -----


    
----- [Start] Data edit -----

-- Save with Index

function saveWithIndex()
    SaveGlobalCounter()
    SaveGlobalTime()
    saveLocalData( "result_"..SectionTestCounter, passedtime )
    saveLocalData( "devide_"..SectionTestCounter, devidetimes )
end

-- Save Last Time

function saveLastTime()
    saveLocalData( "lastTimeResult", passedtime )
end

-- Clear all result
function clearAllResult()
    parameter.clear()
    parameter.action( "Are you sure to clean all results?" )
    parameter.action( "Yes", clearAllResultConfirmed )
    parameter.action( "No", history_menu_parm )
end

function clearAllResultConfirmed()
    clearLocalData()
    resetLocalDataStructure()
    parameter.clear()
    parameter.action( "History Deleted." )
    parameter.action( "= Back to Main Menu =", parm )
end

function resetLocalDataStructure()
    saveLocalData( "GlobalCounter", 0 )
    saveLocalData( "GlobalTime", 0 )
    saveLocalData( "TestAll", 0 )
    saveLocalData( "TestTimes", 0 )
end

----- [End] Data edit -----



----- [Start] Data read -----

-- Read Last Time Result

function readLastestResult()
    LTR = readLocalData( "lastTimeResult" )
    if LTR == nil then
        print( "Data Not Found! Please run a test first!" )
    else
        print( "Last time result: "..LTR.."s")
    end
end

-- Read Specilified Result

function readSpecilifiedResult()
    dataKey = "result_"..Specilified_Time_to_Search
    result = readLocalData( dataKey )
    if result == nil then
        print( "Can't find " .. Specilified_Time_to_Search .. "th info. Please check your input." )
    else
        print( Specilified_Time_to_Search.."th test info:\nResult: "..result.."s" )
    end
end

----- [End] Data read -----