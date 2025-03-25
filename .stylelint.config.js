/**
 * Global stylelint configuration
 * 
 * Prerequisites:
 *   npm install -g stylelint stylelint-order stylelint-config-recess-order
 * 
 * Usage:
 *   stylelint --fix --config="$HOME/.stylelint.config.js" xxx/*.css
 */

export default {
	extends: ['stylelint-config-recess-order'],
}
