import { component$, useBrowserVisibleTask$, useContext, useSignal, useStylesScoped$ } from "@builder.io/qwik";
import { SearchContextID, SearchContext } from "../context";
import searchCSS from "./panel.css?inline";

export const SearchPanel = component$(()=>{
    const searchContext : SearchContext = useContext(SearchContextID);
    const searchSignal = useSignal<Element>();

    useStylesScoped$(searchCSS);
    useBrowserVisibleTask$(({track})=>{
        track(()=>searchContext.open);
        const search = searchSignal.value as HTMLElement;
        if(searchContext.open){
            search.classList.add("search-panel-visible");
        }else{
            search.classList.remove("search-panel-visible");
        }  
    })

    return (
        <input type="text" class="search-panel" ref={searchSignal} placeholder="Search project or character names"/>
    )
});