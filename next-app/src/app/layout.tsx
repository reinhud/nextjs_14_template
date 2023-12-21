import type { Metadata } from 'next';
import { Inter } from 'next/font/google';

import Footer from '../components/footer/footer';
import Header from '../components/header/header';

// Loading the 'Inter' font from Google Fonts, with a subset of 'latin' characters
const inter = Inter({ subsets: ['latin'] });

// Defining metadata for the application
// This metadata is used for SEO and potentially by social media platforms
export const metadata: Metadata = {
    title: 'Next App Template',
    description:
        'Template for dockerized Next.js applications configured with TypeScript, ESLint, Prettier, and Jest.'
};

export default function RootLayout({
    children
}: {
    children: React.ReactNode;
}) {
    return (
        <html lang="en">
            <body>
                <Header />
                {children}
                <Footer />
            </body>
        </html>
    );
}
