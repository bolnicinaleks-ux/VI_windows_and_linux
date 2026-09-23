#ifndef WIN_EVENT_FILTER_H
#define WIN_EVENT_FILTER_H

#include <QAbstractNativeEventFilter>
#include <QWindow>

#ifdef Q_OS_WIN
#include <windows.h>
#include <windowsx.h>
#include <dwmapi.h>

class WinEventFilter : public QAbstractNativeEventFilter {
public:
    explicit WinEventFilter(QWindow *window) : m_window(window) {}

    bool nativeEventFilter(const QByteArray &eventType, void *message, qintptr *result) override {
        if (eventType == "windows_generic_MSG" && m_window) {
            MSG *msg = static_cast<MSG *>(message);
            if (msg->hwnd == reinterpret_cast<HWND>(m_window->winId())) {
                switch (msg->message) {
                case WM_NCCALCSIZE: {
                    if (msg->wParam) {
                        *result = 0;
                        return true;
                    }
                    break;
                }
                case WM_NCHITTEST: {
                    POINT pt = { GET_X_LPARAM(msg->lParam), GET_Y_LPARAM(msg->lParam) };
                    RECT rect;
                    GetWindowRect(msg->hwnd, &rect);

                    const int borderWidth = 8;
                    const int titleBarHeight = 36;

                    bool resizable = !(m_window->flags() & Qt::MSWindowsFixedSizeDialogHint);
                    if (resizable) {
                        if (pt.y >= rect.top && pt.y < rect.top + borderWidth) {
                            if (pt.x >= rect.left && pt.x < rect.left + borderWidth) { *result = HTTOPLEFT; return true; }
                            if (pt.x >= rect.right - borderWidth && pt.x < rect.right) { *result = HTTOPRIGHT; return true; }
                            *result = HTTOP; return true;
                        }
                        if (pt.y >= rect.bottom - borderWidth && pt.y < rect.bottom) {
                            if (pt.x >= rect.left && pt.x < rect.left + borderWidth) { *result = HTBOTTOMLEFT; return true; }
                            if (pt.x >= rect.right - borderWidth && pt.x < rect.right) { *result = HTBOTTOMRIGHT; return true; }
                            *result = HTBOTTOM; return true;
                        }
                        if (pt.x >= rect.left && pt.x < rect.left + borderWidth) { *result = HTLEFT; return true; }
                        if (pt.x >= rect.right - borderWidth && pt.x < rect.right) { *result = HTRIGHT; return true; }
                    }

                    const int rightControlAreaWidth = 280;
                    if (pt.y >= rect.top && pt.y < rect.top + titleBarHeight) {
                        if (pt.x < rect.right - rightControlAreaWidth) {
                            *result = HTCAPTION;
                            return true;
                        }
                    }
                    break;
                }
                }
            }
        }
        return false;
    }

private:
    QWindow *m_window{nullptr};
};

#else

class WinEventFilter : public QAbstractNativeEventFilter {
public:
    explicit WinEventFilter(QWindow *window) : m_window(window) {}
    bool nativeEventFilter(const QByteArray &, void *, qintptr *) override { return false; }
private:
    QWindow *m_window{nullptr};
};

#endif // Q_OS_WIN

#endif // WIN_EVENT_FILTER_H
