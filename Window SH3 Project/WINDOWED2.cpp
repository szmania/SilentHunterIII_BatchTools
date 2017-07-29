#pragma comment(lib,"gdi32.lib")
#pragma comment(lib,"user32.lib")
#include <windows.h>

void WindowResize(HWND hWnd, int nWidth, int nHeight)
{
    RECT rcClient, rcWindow;
    POINT pointDifference;
    GetClientRect(hWnd, &rcClient);
    GetWindowRect(hWnd, &rcWindow);
    pointDifference.x = (rcWindow.right - rcWindow.left) - rcClient.right;
    pointDifference.y = (rcWindow.bottom - rcWindow.top) - rcClient.bottom;
    MoveWindow(hWnd,rcWindow.left, rcWindow.top, nWidth + pointDifference.x, nHeight + pointDifference.y, TRUE);
}

BOOL CALLBACK EnumWindowsProc( HWND hwnd, LONG lParam )
{
    DWORD dwStyle = GetWindowLongPtr( hwnd, GWL_STYLE ) ;
    DWORD dwExStyle = GetWindowLongPtr( hwnd, GWL_EXSTYLE ) ;
    TCHAR buffer[512] = {0};
    SendMessage(hwnd,WM_GETTEXT,sizeof(buffer), (LPARAM)(void*)buffer);
    if(strcmp(buffer, "SilentHunter3") == 0)
    {
        WindowResize(hwnd, 924, 650);
        SetForegroundWindow(hwnd);
        UpdateWindow(hwnd);
    }
    return TRUE;
}

int main(void)
{
    EnumWindows(EnumWindowsProc, NULL);
    return 0;
}
