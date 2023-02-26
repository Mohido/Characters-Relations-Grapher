import { component$, useSignal, useStylesScoped$, useStore, useTask$, useBrowserVisibleTask$ , useContext } from "@builder.io/qwik";
import {MenuContextID} from "../context";
import panelCSS from "./panel.css?inline";




export const MenuPanel = component$(()=>{
    const menuContext = useContext(MenuContextID);
    const menuRef = useSignal<Element>();


    useStylesScoped$(panelCSS);


    useBrowserVisibleTask$( ({track}) => {
        track(() => menuContext.open);
        console.log("panel re-rending.");
        const menuPanel = (menuRef.value as HTMLElement);
        if(menuContext.open){
            menuPanel.classList.add("menu-open");
        }else{
            menuPanel.classList.remove("menu-open");
        }
    });


    return (
        <div class="menu-panel" ref={menuRef}>
            <ul>
                <li>item 1</li>
                <li>item 2</li>
                <li>item 3</li>
            </ul>
        </div>
    );
});