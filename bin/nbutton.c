/*
 * gcc -o nbutton nbutton.c -lXt -lXaw
 *
 * while read msg; do
 *     case "$msg" in
 *     "first button")
 *         echo "button 1 pressed"
 *         ;;
 *     "second button")
 *         echo "button 2 pressed"
 *         ;;
 *     esac
 * done < <(./nbutton "first button" "second button")
 */


#include <X11/Intrinsic.h>
#include <X11/StringDefs.h>
#include <X11/Xaw/Box.h>
#include <X11/Xaw/Command.h>
#include <stdio.h>
#include <stdlib.h>

void quit(Widget w, XtPointer client_data, XtPointer call_data)
{
    exit(0);
}

void bprint(Widget w, XtPointer client_data, XtPointer call_data)
{
    printf("%s\n", client_data);
    fflush(stdout);
}

int main(int argc, char **argv)
{
    Widget toplevel, box, command, buttons[64];
    Arg wargs[10];
    int n=0;

    toplevel = XtInitialize(argv[0], "nbutton", NULL, 0, &argc, argv);

    box = XtCreateManagedWidget("box", boxWidgetClass, toplevel, NULL, 0);
    XtSetArg(wargs[n], XtNorientation, XtorientHorizontal); n++;
    XtSetArg(wargs[n], XtNhSpace, 10); n++;
    XtSetArg(wargs[n], XtNvSpace, 10); n++;
    XtSetValues(box, wargs, n);

    command = XtCreateManagedWidget("quit", commandWidgetClass, box, NULL, 0);
    XtAddCallback(command, XtNcallback, quit, NULL);

    for(int a=1; a<argc; a++)
    {
        buttons[a-1] = XtCreateWidget(argv[a], commandWidgetClass, box, NULL, 0);
        XtAddCallback(buttons[a-1], XtNcallback, bprint, argv[a]);
    }

    XtManageChildren(buttons, argc-1);
    XtRealizeWidget(toplevel);
    XtMainLoop();
    return 0;
}
