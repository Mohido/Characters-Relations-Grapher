import { component$, useContextProvider , useStore} from "@builder.io/qwik";
import { SearchButton } from "./button/button";
import { SearchPanel } from "./panel/panel";
import {SearchContextID, SearchContext} from "./context";


export default component$(()=>{
    useContextProvider(SearchContextID, useStore<SearchContext>({open:false}));

    return (
        <div style="position:relative;">
            <SearchPanel></SearchPanel>
            <SearchButton></SearchButton>
        </div>
    )
})