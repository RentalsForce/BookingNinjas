import { api, LightningElement } from 'lwc';
// Custom labels
export default class Popup extends LightningElement {
    @api title;
    @api loading;
    @api width;
    @api noHeader;
    @api noScroll;
    @api hideCloseButton = false;
    @api disableClose = false;
    @api nestingLevel = 1;
    @api close() {
        this.closeModal();
    }

    isRendered = false;
    zIndexContentStyle = '';
    zIndexBackgroundStyle = '';

    label = { labelClose: 'Close' };

    hasFooter = false;

    closeModal() {
        this.closePopupAnimation();
        this.checkBodyOverflowBeforeClose();
        // eslint-disable-next-line @lwc/lwc/no-async-operation
        setTimeout(() => {
            this.dispatchEvent(new CustomEvent('close'));
        }, 200);
    }

    handleFooterSlotChange(event) {
        const slot = event.target;
        const hasFooter = slot?.assignedElements().length !== 0;
        this.hasFooter = hasFooter;
    }

    get containerStyle() {
        return this.width ? 'max-width: ' + this.width : '';
    }

    get contentClasses() {
        return this.noScroll
            ? 'slds-modal__content bn-modal__content bn-modal__content--no-scroll'
            : 'slds-modal__content bn-modal__content ';
    }

    getZIndex() {
        let zIndex = 9000 + +this.nestingLevel * 2;
        this.zIndexContentStyle = 'z-index: ' + zIndex;
        this.zIndexBackgroundStyle = 'z-index: ' + --zIndex;
    }

    openPopupAnimation() {
        this.isRendered = true;
        // eslint-disable-next-line @lwc/lwc/no-async-operation
        setTimeout(() => {
            this.template.querySelector('.bn-modal').classList.add('bn-modal_open');
            this.template.querySelector('.slds-backdrop').classList.add('slds-backdrop_open');
        }, 50);
    }

    closePopupAnimation() {
        this.template.querySelector('.bn-modal').classList.remove('bn-modal_open');
        this.template.querySelector('.slds-backdrop').classList.remove('slds-backdrop_open');
    }

    connectedCallback() {
        document.body.style.overflow = 'hidden';
        this.getZIndex();
    }

    renderedCallback() {
        if (!this.isRendered) {
            this.openPopupAnimation();
        }
    }

    disconnectedCallback() {
        this.checkBodyOverflowBeforeClose();
    }

    checkBodyOverflowBeforeClose() {
        if (+this.nestingLevel === 1) {
            document.body.style.overflow = 'auto';
        }
    }
}
