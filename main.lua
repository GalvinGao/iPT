--[[

    iPad Performance Tester

        Author: Galvin Gao
        GitHub: http://github.com/GalvinGao/iPT


    This program is designed for testing iPad performance.
    
    The principle is the iPad will find the power of pi for 50,000,000 times and measure the time it takes.

    [!] Disclaimer: This program is designed for testing the performance and the author doesn't assume any damage on anything. The test may broken your iPad if you are using it with a big frequence. Please be responsible to your own device.

]]--

supportedOrientations( LANDSCAPE_ANY )  

function setup()
    -- Save Project Info
    saveProjectInfo( "Description", "This program is designed for testing iPad performance. The principle is the iPad will find the power of pi for 50,000,000 times and measure the time it takes." )
    saveProjectInfo( "Author", "Galvin Gao" )
    
    -- Setup Variable
    setupVar()
    
    -- Menu Setup - Parameter
    parm()
end

function setupVar()
    -- Setup Section Test Counter
    SectionTestCounter = 0
    
    -- Setup Searching Enter Box
    Enter_Specilified_Time_for_Searching = 0
    
    -- Setup FPS Calculate materials - FramesPassed
    fP = 0
    
    -- Setup FPS Calculate materials - LastTime(ElapsedTimeNeedToMinus)
    LT = 0
    
    -- Setup Global Test Counter
    GlobalTestCounter = 0
    
    -- Setup Test Counter Var1
    SaveTimeGC = 0
    
    -- Setup Test Counter Var2
    LastTimeGC = 0
    
    -- Setup Test Counter Var3
    SaveTimeGT = 0
    
    -- Setup Test Counter Var4
    LastTimeGT = 0
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
    background( 100, 120, 160, 150 )
    font( "Futura-MediumItalic" )
    fill( 255 )
    fontSize( 20 )
    textWrapWidth( 500 )
    
    -- Shows the discription
    text( "This test will make your iPad to find the power of π for 50000000 times.\n\nPlease mind, the test may take a while to run, please be patient.\n\n\nAverage:\n8.657363s", WIDTH/2, HEIGHT/2 )
    
    -- Shows the FPS
    fontSize( 11 )
    font( "CourierNewPS-BoldMT" )
    text( "FPS: "..fps, WIDTH/2+WIDTH/4, HEIGHT/2+WIDTH/4 )
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
    parameter.clear()
    parameter.action( "== Back ==", parm )
    parameter.watch( "SectionTestCounter" )
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
    GlobalTimeUsed = readLocalData( "GlobalTime" )
end

-- Test Counter Menu - Global Time Used Saver

function SaveGlobalTime()
    LastTimeGT = readLocalData( "GlobalTime" )
    SaveTimeGT = LastTimeGT + passedtime
    saveLocalData( "GlobalTime", SaveTimeGT )
    LastTimeGT = 0
    SaveTimeGT = 0
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
    print( passedtime .. " s" )
    SectionTestCounter = SectionTestCounter + 1
    saveWithIndex()
    saveLastTime()
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
        print( i.."th test is done.\nResult: "..passedtime.."s\nFPS: "..fps )
        SectionTestCounter = SectionTestCounter + 1
        saveWithIndex()
        saveLastTime()
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
        print( i.."th test is done.\nResult: "..passedtime.."s\nFPS: "..fps )
        SectionTestCounter = SectionTestCounter + 1
        saveWithIndex()
        saveLastTime()
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
        print( i.."th test is done.\nResult: "..passedtime.."s\nFPS: "..fps )
        SectionTestCounter = SectionTestCounter + 1
        saveWithIndex()
        saveLastTime()
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
        print( i.."th test is done.\nResult: "..passedtime.."s\nFPS: "..fps )
        SectionTestCounter = SectionTestCounter + 1
        saveWithIndex()
        saveLastTime()
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
    parameter.clear()
    parameter.action( "History Deleted." )
    parameter.action( "= Back to Main Menu =", parm )
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
