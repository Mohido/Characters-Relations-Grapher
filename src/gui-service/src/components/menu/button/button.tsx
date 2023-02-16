import { component$, useBrowserVisibleTask$, useContext, useContextProvider, useStylesScoped$, useSignal } from "@builder.io/qwik";
import buttonCSS from "./button.css?inline" ;
import {MenuContextID} from "../context";

export const MenuButton = component$(()=>{
    const menuContext = useContext(MenuContextID);  // Menu Properties.
    const buttonElement = useSignal<Element>();     // Contains the button html element
    useStylesScoped$(buttonCSS);                    // Using CSS styles for this ocmponent

    /// Tracks if the menu is opened and update the css class of the button
    useBrowserVisibleTask$(({track}) => {
        track(() => menuContext.open);
        const buttonHTMLElement = (buttonElement.value as HTMLElement);
        if(menuContext.open){
            buttonHTMLElement.classList.add('menu-open-button-translation');
        }else{
            buttonHTMLElement.classList.remove('menu-open-button-translation');
        }
    })
   

    return (
        <button class="menu-button" ref={buttonElement} onClick$={()=> {menuContext.open=!menuContext.open}} >
            <i class="fa-solid fa-bars"></i>
            <i class="fa-solid fa-arrow-right"></i>
        </button>
        
    );
});
