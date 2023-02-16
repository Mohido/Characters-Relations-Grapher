import { component$, useContextProvider , useStore} from "@builder.io/qwik";
import { MenuButton } from "./button/button";
import { MenuPanel } from "./panel/panel";
import {MenuContextID, MenuContext} from "./context";


export default component$(()=>{
    useContextProvider(MenuContextID, useStore<MenuContext>({open:false}));

    return (
        <div style="position:relative;">
            <MenuPanel></MenuPanel>
            <MenuButton></MenuButton>
        </div>
    )
})