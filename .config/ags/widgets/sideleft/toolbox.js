import { Widget } from '../../imports.js';
const { Box, Scrollable } = Widget;
import { QuickScripts } from './quickscripts.js';

export default Scrollable({
    hscroll: "never",
    vscroll: "automatic",
    child: Box({
        vertical: true,
        children: [
            QuickScripts(),
        ]
    })
});
