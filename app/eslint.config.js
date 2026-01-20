const { defineConfig } = require("eslint/config");
const html = require("eslint-plugin-html")

module.exports = defineConfig([
	{
    files: ["**/*.html"],
    plugins: {
      html: html
    },
		rules: {
		  "no-unused-vars": "warn",
      "no-console": "off"
		},
	},
]);

