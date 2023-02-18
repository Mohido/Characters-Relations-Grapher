import { component$, useBrowserVisibleTask$, useContext, useContextProvider, useStylesScoped$, useSignal } from "@builder.io/qwik";
import buttonCSS from "./button.css?inline" ;
import {ProfileContextID} from "../context";

export const ProfileButton = component$(()=>{
    const profileContext = useContext(ProfileContextID);  // Profile Properties.
    const buttonElement = useSignal<Element>();     // Contains the button html element
    useStylesScoped$(buttonCSS);                    // Using CSS styles for this ocmponent

    // /// Tracks if the profile is opened and update the css class of the button
    // useBrowserVisibleTask$(({track}) => {
    //     track(() => profileContext.open);
    //     const buttonHTMLElement = (buttonElement.value as HTMLElement);
    // })
   

    return (
        <button class="profile-button" ref={buttonElement} onClick$={()=> {profileContext.open=!profileContext.open}} >
            <i class="fa-solid fa-person"></i>
        </button>
    );
});
