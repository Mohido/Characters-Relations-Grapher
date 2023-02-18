import { component$, useBrowserVisibleTask$, useContext, useStylesScoped$, useSignal } from "@builder.io/qwik";
import buttonCSS from "./button.css?inline" ;
import {SearchContextID} from "../context";

export const SearchButton = component$(()=>{
    const searchContext = useContext(SearchContextID);  // Search Properties.
    const buttonElement = useSignal<Element>();     // Contains the button html element
    useStylesScoped$(buttonCSS);                    // Using CSS styles for this ocmponent

    /// Tracks if the search is opened and update the css class of the button
    useBrowserVisibleTask$(({track}) => {
        track(() => searchContext.open);
        const buttonHTMLElement = (buttonElement.value as HTMLElement);
        if(searchContext.open){
            buttonHTMLElement.classList.add('search-button-active');
        }else{
            buttonHTMLElement.classList.remove('search-button-active');
        }
    })
   

    return (
        <button class="search-button" ref={buttonElement} onClick$={()=> {searchContext.open=!searchContext.open}} >
           <i class="fa-solid fa-magnifying-glass"></i>
        </button>
        
    );
});
