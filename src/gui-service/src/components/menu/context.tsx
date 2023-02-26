import { createContextId } from "@builder.io/qwik";

export interface MenuContext {
    open: boolean
}

export const MenuContextID = createContextId<MenuContext>("MenuContext");