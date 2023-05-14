/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./js/**/*.js", "../lib/*_web.ex", "../lib/*_web/**/*.*ex"],
  theme: {
    extend: {
      fontFamily: {
        serif: [
          "Merriweather",
          "Book Antiqua",
          "Georgia",
          "Century Schoolbook",
          "serif",
        ],
        sans: [
          "Inter"
        ]
      }
    },
  },
  plugins: [],
};
