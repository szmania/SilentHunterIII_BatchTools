#pragma comment(lib,"gdi32.lib")
#pragma comment(lib,"user32.lib")
#include <windows.h>

#define IDC_MAIN_BUTTON	101			// Button identifier
#define FULLSCREEN 0
#define WINDOWED 1

LRESULT CALLBACK WinProc(HWND hWnd,UINT message,WPARAM wParam,LPARAM lParam);

void CenterWindow(HWND hwndWindow)
{
    HWND hParent = GetDesktopWindow();
    RECT rcChild = {0}, rcParent = {0};
    int nWidth, nHeight, nX, nY;

    // make the window relative to its parent
    GetWindowRect(hwndWindow, &rcChild);
    GetWindowRect(hParent, &rcParent);

    nWidth = (rcChild.right - rcChild.left) / 2;
    nHeight = (rcChild.bottom - rcChild.top) /2;
    nX = ((rcParent.right - rcParent.left) - nWidth) / 2 + rcParent.left;
    nY = ((rcParent.bottom - rcParent.top) - nHeight) / 2 + rcParent.top;


    int nScreenWidth = GetSystemMetrics(SM_CXSCREEN);
    int nScreenHeight = GetSystemMetrics(SM_CYSCREEN);

    // make sure that the dialog box never moves outside of the screen
    if (nX < 0) nX = 0;
    if (nY < 0) nY = 0;
    if (nX + nWidth > nScreenWidth) nX = nScreenWidth - nWidth;
    if (nY + nHeight > nScreenHeight) nY = nScreenHeight - nHeight;

    MoveWindow(hwndWindow, nX, nY, nWidth, nHeight, FALSE);
}

BOOL CALLBACK EnumWindowsProc( HWND hwnd, LONG lParam )
{
    TCHAR buffer[512] = {0};
    SendMessage(hwnd,WM_GETTEXT,sizeof(buffer), (LPARAM)(void*)buffer);
    // Change Window1 to game binary window name
    if(strcmp(buffer, "SilentHunter3") == 0)
	{
        if(lParam == WINDOWED)
        {
            SetForegroundWindow(hwnd);
            CenterWindow(hwnd);
            UpdateWindow(hwnd);
        }
        else if(lParam == FULLSCREEN)
        {
            SetForegroundWindow(hwnd);
            ShowWindow(hwnd, SW_MINIMIZE);
            ShowWindow(hwnd, SW_MAXIMIZE);
            UpdateWindow(hwnd);
        }
    return FALSE;
	}
return TRUE;
}

int WINAPI WinMain(HINSTANCE hInst,HINSTANCE hPrevInst,LPSTR lpCmdLine,int nShowCmd)
{
    WNDCLASSEX wClass;
    ZeroMemory(&wClass,sizeof(WNDCLASSEX));
    wClass.cbClsExtra=NULL;
    wClass.cbSize=sizeof(WNDCLASSEX);
    wClass.cbWndExtra=NULL;
    wClass.hbrBackground=(HBRUSH)COLOR_WINDOW;
    wClass.hCursor=LoadCursor(NULL,IDC_ARROW);
    wClass.hIcon=NULL;
    wClass.hIconSm=NULL;
    wClass.hInstance=hInst;
    wClass.lpfnWndProc=(WNDPROC)WinProc;
    wClass.lpszClassName="Window Class";
    wClass.lpszMenuName=NULL;
    wClass.style=CS_HREDRAW|CS_VREDRAW;

    if(!RegisterClassEx(&wClass))
    {
        int nResult=GetLastError();
        MessageBox(NULL,
                   "Window class creation failed\r\n",
                   "Window Class Failed",
                   MB_ICONERROR);
    }

    HWND hWnd=CreateWindowEx(NULL,
                             "Window Class",
                             "Windows application",
                             WS_OVERLAPPEDWINDOW,
                             200,
                             200,
                             640,
                             480,
                             NULL,
                             NULL,
                             hInst,
                             NULL);

    if(!hWnd)
    {
        int nResult=GetLastError();

        MessageBox(NULL,
                   "Window creation failed\r\n",
                   "Window Creation Failed",
                   MB_ICONERROR);
    }

    ShowWindow(hWnd,nShowCmd);

    MSG msg;
    ZeroMemory(&msg,sizeof(MSG));

    while(GetMessage(&msg,NULL,0,0))
    {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }

    return 0;
}

LRESULT CALLBACK WinProc(HWND hWnd,UINT msg,WPARAM wParam,LPARAM lParam)
{
    switch(msg)
    {
    case WM_CREATE:
    {

        // Create a push button
        HWND hWndButton=CreateWindowEx(NULL,
                                       "BUTTON",
                                       "Start Processing",
                                       WS_TABSTOP|WS_VISIBLE|
                                       WS_CHILD|BS_DEFPUSHBUTTON,
                                       10,
                                       100,
                                       200,
                                       48,
                                       hWnd,
                                       (HMENU)IDC_MAIN_BUTTON,
                                       GetModuleHandle(NULL),
                                       NULL);
    }
    break;

    case WM_COMMAND:
        switch(LOWORD(wParam))
        {
        case IDC_MAIN_BUTTON:
        {
            // firstapp is changed to Windowed
            EnumWindows(EnumWindowsProc, WINDOWED);
            Sleep(5000);
            // Bring secondapp to foreground
            SetForegroundWindow(hWnd);
            Sleep(5000);
            // Maximize first app
            EnumWindows(EnumWindowsProc, FULLSCREEN);
            Sleep(5000);
            // Terminate secondapp
            PostQuitMessage(0);
        }
        break;
        }
        break;
    case WM_QUIT:
        EnumWindows(EnumWindowsProc, FULLSCREEN);
        break;
    case WM_DESTROY:
    {
        PostQuitMessage(0);
        return 0;
    }
    break;
    }
     return DefWindowProc(hWnd,msg,wParam,lParam);
}
