import { createContextId } from "@builder.io/qwik";

export interface SearchContext {
    open: boolean
}

export const SearchContextID = createContextId<SearchContext>("SearchContext");