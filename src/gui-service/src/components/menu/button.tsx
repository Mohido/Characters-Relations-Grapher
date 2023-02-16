import { component$, useStylesScoped$ } from "@builder.io/qwik";
import buttonCSS from "./button.css?inline" ;


export const MenuButton = component$(()=>{

    useStylesScoped$(buttonCSS);
    return (
        <span>
            <button class="menu-button">
            <i class="fa-solid fa-bars"></i><i class="fa-solid fa-arrow-right"></i>
            </button>
        </span>
    );
});
