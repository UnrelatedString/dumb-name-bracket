import type { RollupOptions } from 'rollup';
import dev from 'rollup-plugin-dev';
import html from '@rollup/plugin-html';
import terser from '@rollup/plugin-terser';
import copy from 'rollup-plugin-copy';

const config = (args: Record<string, any>): RollupOptions => ({
	input: 'src/index.mjs',
	output: {
		dir: 'dist',
		format: 'es'
	},
    plugins: [
        copy({
            targets: [
                { src: 'static/**/*', dest: 'dist' }
            ],
        }),
        html({
            title: "Dumb Name Bracket",
            meta: [
                { charset: 'utf-8' },
                { property: 'og:type', content: 'website' },
                { property: 'og:title', content: 'Dumb Name Bracket' },
                { property: 'og:description', content: 'a dumb bracket for names that is not as smart as it sounds' },
                { property: 'og:url', content: 'https://unrelatedstring.github.io/dumb-name-bracket' },
            ],
            attributes: {
                html: { lang: 'en' },
                link: { rel: 'icon', href: 'favicon.ico' },
            },
        }),
        dev({
            dirs: ["dist"],
            force: args.configServe,
        }),
        terser(),
    ],
});
export default config;
