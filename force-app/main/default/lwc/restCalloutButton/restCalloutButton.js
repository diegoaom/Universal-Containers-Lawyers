import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getData from '@salesforce/apex/Ucl_RestCallout.getData';

export default class RestCalloutButton extends LightningElement {
    async invokeService() {
        try {
            const result = await getData();
            
            console.log('Service Result:', result);
            const toastEvent = new ShowToastEvent({
                title: 'Service Invocation',
                message: 'Service invoked successfully!',
                variant: 'success',
            });
            this.dispatchEvent(toastEvent);
        } catch (error) {
            console.error('Service Error:', error);
            const toastEvent = new ShowToastEvent({
                title: 'Service Invocation Error',
                message: 'An error occurred while invoking the service.',
                variant: 'error',
            });
            this.dispatchEvent(toastEvent);
        }
    }
}