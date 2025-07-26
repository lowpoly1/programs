from tkinter import *
from pynput.keyboard import Key, Controller
from PIL import Image, ImageTk, ImageOps
import webbrowser

keyboard = Controller()

# set up functions to control media keys
def play_pause():
    keyboard.press(Key.media_play_pause)

def previous():
    keyboard.press(Key.media_previous)

def next():
    keyboard.press(Key.media_next)

def vol_up():
    keyboard.press(Key.media_volume_up)

def vol_down():
    keyboard.press(Key.media_volume_down)

def voyager():
    webbrowser.open("https://www.paramountplus.com/shows/star_trek_voyager/")

def google():
    webbrowser.open("https://www.google.com")

# create main window "m"
m = Tk()
m.title("Media Control Center")
m.geometry("600x200")

# store icons as images, for dynamic resizing with pillow
img_play_pause = Image.open(".\\icons\\playpause.png")
img_previous = Image.open(".\\icons\\previous.png")
img_next = Image.open(".\\icons\\next.png")
img_vol_up = Image.open(".\\icons\\volumeup.png")
img_vol_down = Image.open(".\\icons\\volumedown.png")

# convert the images to PhotoImage format so tkinter can read them
ico_play_pause = ImageTk.PhotoImage(img_play_pause)
ico_previous = ImageTk.PhotoImage(img_previous)
ico_next = ImageTk.PhotoImage(img_next)
ico_vol_up = ImageTk.PhotoImage(img_vol_up)
ico_vol_down = ImageTk.PhotoImage(img_vol_down)

# create buttons with icons
b_previous = Button(m, image=ico_previous, command=previous)
b_play_pause = Button(m, image=ico_play_pause, command=play_pause)
b_next = Button(m, image=ico_next, command=next)
b_vol_down = Button(m, image=ico_vol_down, command=vol_down)
b_vol_up = Button(m, image=ico_vol_up, command=vol_up)

# links
b_voyager = Button(m, text="Voyager", command=voyager)
b_google = Button(m, text="Google", command=google)

def resize_images(event):
    # declare global variables
    global img_play_pause
    global img_previous
    global img_next
    global img_vol_up
    global img_vol_down
    global ico_play_pause
    global ico_previous
    global ico_next
    global ico_vol_up
    global ico_vol_down
    global b_play_pause
    global b_previous
    global b_next
    global b_vol_up
    global b_vol_down

    # update the images in the variable to avoid losing resolution when resizing window
    img_play_pause = Image.open(".\\icons\\playpause.png")
    img_previous = Image.open(".\\icons\\previous.png")
    img_next = Image.open(".\\icons\\next.png")
    img_vol_up = Image.open(".\\icons\\volumeup.png")
    img_vol_down = Image.open(".\\icons\\volumedown.png")

    # dynamically resize the icons to fit the button when button is smaller
    size = (m.winfo_width()//3, m.winfo_height())
    # print(size)
    # size = (256, 256)
    img_play_pause = ImageOps.contain(img_play_pause, size)
    img_previous = ImageOps.contain(img_previous, size)
    img_next = ImageOps.contain(img_next, size)
    img_vol_up = ImageOps.contain(img_vol_up, size)
    img_vol_down = ImageOps.contain(img_vol_down, size)

    # update icons in memory buffer from newly resized images
    ico_play_pause = ImageTk.PhotoImage(img_play_pause)
    ico_previous = ImageTk.PhotoImage(img_previous)
    ico_next = ImageTk.PhotoImage(img_next)
    ico_vol_up = ImageTk.PhotoImage(img_vol_up)
    ico_vol_down = ImageTk.PhotoImage(img_vol_down)

    # update buttons with resized icons
    b_play_pause.configure(image=ico_play_pause)
    b_previous.configure(image=ico_previous)
    b_next.configure(image=ico_next)
    b_vol_up.configure(image=ico_vol_up)
    b_vol_down.configure(image=ico_vol_down)

# set up grid for dynamic resizing of buttons
Grid.rowconfigure(m, 0, weight = 2)
Grid.rowconfigure(m, 1, weight = 1)
Grid.rowconfigure(m, 2, weight = 1)
Grid.columnconfigure(m, 0, weight = 2)
Grid.columnconfigure(m, 1, weight = 2)
Grid.columnconfigure(m, 2, weight = 2)

# put buttons in their appropriate places
b_previous.grid(row = 0, column = 0)
b_play_pause.grid(row = 0, column = 1)
b_next.grid(row = 0, column = 2)
b_vol_down.grid(row = 1, column = 0, rowspan = 2)
b_voyager.grid(row = 1, column = 1, sticky="NSEW")
b_google.grid(row = 2, column = 1, sticky="NSEW")
b_vol_up.grid(row = 1, column = 2, rowspan = 2)

# dynamically resize icons whenever the window is resized
m.bind("<Configure>", resize_images)

# start the main window loop
m.mainloop()
