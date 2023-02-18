import { createContextId } from "@builder.io/qwik";

export interface ProfileContext {
    open: boolean
}

export const ProfileContextID = createContextId<ProfileContext>("ProfileContext");