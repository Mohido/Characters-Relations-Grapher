import { component$, Slot, useStylesScoped$ } from "@builder.io/qwik";
import contentCSS from "./index.css?inline"


export const Content = component$(()=>{
    useStylesScoped$(contentCSS);
    return (
        <div class="content">
            <Slot/>
        </div>
    );
})