import { component$ } from '@builder.io/qwik';
import type { DocumentHead } from '@builder.io/qwik-city';
import { Link } from '@builder.io/qwik-city';

export default component$(() => {
    return (
        <h1>Hello From CGR QWIK</h1>
    );
});

export const head: DocumentHead = {
    title: 'CGR',
    meta: [
        {
            name: 'cgr describetion',
            content: 'content',
        },
    ],
};
