import { LightningElement } from 'lwc';

export default class onclick_1 extends LightningElement {
    isChangePanel = true;

    clickedButton(){
        if(this.isChangePanel) {
            this.isChangePanel = false;
        } else {
            this.isChangePanel = true;
        }
        // this.isChangePanel = false;
    }
}