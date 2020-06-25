'use babel';

import AtomAsciidocHelpersView from './atom-asciidoc-helpers-view';
import { CompositeDisposable } from 'atom';

export default {

  atomAsciidocHelpersView: null,
  modalPanel: null,
  subscriptions: null,

  activate(state) {
    this.atomAsciidocHelpersView = new AtomAsciidocHelpersView(state.atomAsciidocHelpersViewState);
    this.modalPanel = atom.workspace.addModalPanel({
      item: this.atomAsciidocHelpersView.getElement(),
      visible: false
    });

    // Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    this.subscriptions = new CompositeDisposable();

    // Register command that toggles this view
    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'atom-asciidoc-helpers:toggle': () => this.toggle()
    }));
  },

  deactivate() {
    this.modalPanel.destroy();
    this.subscriptions.dispose();
    this.atomAsciidocHelpersView.destroy();
  },

  serialize() {
    return {
      atomAsciidocHelpersViewState: this.atomAsciidocHelpersView.serialize()
    };
  },

  toggle() {
    console.log('AtomAsciidocHelpers was toggled!');
    return (
      this.modalPanel.isVisible() ?
      this.modalPanel.hide() :
      this.modalPanel.show()
    );
  }

};
