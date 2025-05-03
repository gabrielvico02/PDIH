import ctypes
from ctypes import wintypes # Librería para acceder al mouse

def move_mouse(dx, dy): # Permite mover el mouse a coordenadas relativas
    pt = wintypes.POINT()
    ctypes.windll.user32.GetCursorPos(ctypes.byref(pt))
    ctypes.windll.user32.SetCursorPos(pt.x + dx, pt.y + dy)

def apply_deadzone(value, threshold=0.1): # Zona muerta: evitar movimientos involutarios como temblores
    return 0 if abs(value) < threshold else value

def update():
    global cursorScale

    # Botones
    mouse.leftButton   = freePieIO[3].yaw == 1
    mouse.rightButton  = int(freePieIO[3].x) & 0b00010000 > 0
    mouse.middleButton = int(freePieIO[3].x) & 0b00000001 > 0

    # Movimiento con zona muerta
    yaw = apply_deadzone(freePieIO[1].yaw)
    pitch = apply_deadzone(freePieIO[1].pitch)

    # Calcular las nuevas coordenadas
    dx = int(-yaw * cursorScale * 4)
    dy = int(-pitch * cursorScale * 4)

    move_mouse(dx, dy)

if starting:
    cursorScale = 5  # Sensibilidad
    freePieIO[0].update += update
