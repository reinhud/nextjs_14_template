import Link from 'next/link';
import React from 'react';

export default function Home() {
    return (
        <main>
            <h1>Home Page</h1>
            <Link href="/about">About</Link>
        </main>
    );
}
