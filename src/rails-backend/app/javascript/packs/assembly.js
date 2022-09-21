
Vue.component('documentation', {
  data: function () {
    return {
      showDocs: false,
    }
  },
  template: `
  <div>
    <div class="row">
      <div class="col-8"></div>
      <div class="col-4">
        <button class="btn btn-primary" v-if="!showDocs" @click="showDocs = !showDocs">Show Documentation</button>
        <button class="btn btn-secondary" v-else @click="showDocs = !showDocs">Hide Documentation</button>
      </div>
    </div>
    <div class="row" v-if="showDocs">
      <div class="col">
        <p class="lead"> 
          This is a virtual machine that runs Richard's assembly language.
        </p>
        <p>
          The architecture of the machine is very simple.  It has 20 memory locations available for the program instructions, and 20 memory locations for data storage.
          These are called <i>memory segments</i>.
        </p>
        <p>
          <b>The Program Counter</b>  There is a special memory location called the program counter.  It gives the value of the next instruction to be executed.
          It will always have a value between 1 and 20.  Changing this value allows you to jump around to different parts of the code.
        </p>
        <p>
          <b> Data Types: </b>  Primitive data types are written as their normal values.  So if I write <kbd>1</kbd> that means the integer with value 1.  If I write
          <kbd>true</kbd> it means the boolean value true, and so on.
        </p>
        <p>
          If I want to refer to a memory address location in the data segment, I would prefix with a hash.  So <kbd>#3</kbd> refers to memory address location number 3.
          I cannot access memory locations in the program segment.  The program is simply loaded into memory for me by the operating system and it runs.
        </p>
        <p>
          If I want to refer to a pointer, i.e. to read not what's in the memory  location, but what's in the value of the memory location of what's in the memory location,
          I use a *.  So for example, if memory location 4 had the value 5 in it, and memory location 5 had the value 'c' in it,
          then <kbd>*4</kbd> would actually refer to the value in memory address location 5 which is 'c'.
        </p>
        <p>
          <b> Instructions </b> You have the following control instructions available:
          <ul>
            <li> <code>COPY(memLocFrom, memLocTo)</code> This copies whatever is in memLocFrom to memLocTo.  So for example, COPY(1,3) copies whatever is in memory 
            location 1 to memory location 3</li>
            <li> <code>GOTO(instructionNumber)</code>  This will update the program counter to whatever instruction you require to be executed next </li>
            <li> <code>IF(memLoc, instructionNumber)</code>  This will check the value of what's in memLoc, and if that is a boolean value true, it will 
            jump to the instructionNumber provided.  Otherwise it will do nothing and move to the next instruction </li>
          </ul>
          You have the following Arithmetic and Logic instructions available (ALU):
          <ul>
            <li> <code>ADD(memLoc1, memLoc2, memLocAnswer) </code>  This will add the two values in memLoc1 and memLoc2 and put the answer in memLocAnswer.
            There are 4 such functions, like <code>MUL(memLoc1, memLoc2, memLocAnswer)</code>, and for <code>SUB</code> and <code>DIV</code> they all behave the same.
            </li>
            <li> There are 4 comparison instructions, they are: <code>GT</code>, <code>GTE</code>, <code>LT</code>, <code>LTE</code>, <code>EQ</code>.  In other words, Greater Than,
            Greater Than or Equal, Less Than, Less Than or Equal.  Here you again supply 3 memory locations, the first two for comparison and the third for the result.
            For example: <code>GTE(memLoc1, memLoc2, memLocAnswer)</code> would compare if the value in memLoc1 is greater than or equal to the value in memLoc2, and set 
            memLocAnswer to either be True or False
            </li>
            <li> Then you have logic operations.  These are <code>AND</code>, <code>OR</code>, <code>XOR</code>, <code>NOT</code>.  Most of these require 3 memory locations,
            for example <code>AND(memLoc1, memLoc2, memLocAnswer)</code> Would compare memLoc1 and memLoc2, and put the result in memLocAnswer.  The only exception is the <code>NOT</code>
            command, which inverts the input and sets it to the output.  So <code>NOT(memLocIn, memLocOut)</code> would set memLocOut to be the reverse to memLocIn.
            </li>
          </ul> 
          And then we have input and output commands, (I/O):
          <ul>
            <li> <code>READ(memLocTo)</code>  This will read a value from the input stream and put it in memory location: memLocTo</li>
            <li> <code>SEND(memLocFrom)</code> This will send whatever is in memLocFrom and send it to the output stream</li>
          </ul>
        </p>
      </div>
    </div>
  </div>
  `
});

Vue.component('virtual-machine', {
  data: function() {
    return {
      dataSegment: {
        size: 20,
        values: [],
      },
      programSegment: {
        size: 20,
        values: [],
      },
      programCounter: 1,
      nextInstructionForm: {
        nextInstruction: `COPY`,
        args: [],
      },
      instructionArgs: {
        COPY: [
          {
            name: `memLocFrom`,
            allowPointers: true,
            values: `memory`,
          },
          {
            name: `memLocTo`,
            allowPointers: true,
            values: `memory`,
          }
        ],
        GOTO: [
          {
            name: `instructionNumber`,
            allowPointers: true,
            values: `memory`,
          }
        ],
        IF: [
          {
            name: `memLoc`,
            allowPointers: true,
            values: `memory`,
          }
        ],
        ADD: [
          {
            name: `memLoc1`,
            allowPointers: false,
            values: `memory`,
          },
          {
            name: `memLoc2`,
            allowPointers: false,
            values: `memory`,
          },
          {
            name: `memLocAnswer`,
            allowPointers: true,
            values: `memory`,
          }
        ],
        SUB: [
          {
            name: `memLoc1`,
            allowPointers: false,
            values: `memory`,
          },
          {
            name: `memLoc2`,
            allowPointers: false,
            values: `memory`,
          },
          {
            name: `memLocAnswer`,
            allowPointers: true,
            values: `memory`,
          }
        ],
        MUL: [
          {
            name: `memLoc1`,
            allowPointers: false,
            values: `memory`,
          },
          {
            name: `memLoc2`,
            allowPointers: false,
            values: `memory`,
          },
          {
            name: `memLocAnswer`,
            allowPointers: true,
            values: `memory`,
          }
        ],
        DIV: [
          {
            name: `memLoc1`,
            allowPointers: false,
            values: `memory`,
          },
          {
            name: `memLoc2`,
            allowPointers: false,
            values: `memory`,
          },
          {
            name: `memLocAnswer`,
            allowPointers: true,
            values: `memory`,
          }
        ],
        GT: [
          {
            name: `memLoc1`,
            allowPointers: false,
            values: `memory`,
          },
          {
            name: `memLoc2`,
            allowPointers: false,
            values: `memory`,
          },
          {
            name: `memLocAnswer`,
            allowPointers: true,
            values: `memory`,
          }
        ],
        GTE: [
          {
            name: `memLoc1`,
            allowPointers: false,
            values: `memory`,
          },
          {
            name: `memLoc2`,
            allowPointers: false,
            values: `memory`,
          },
          {
            name: `memLocAnswer`,
            allowPointers: true,
            values: `memory`,
          }
        ],
        LT: [
          {
            name: `memLoc1`,
            allowPointers: false,
            values: `memory`,
          },
          {
            name: `memLoc2`,
            allowPointers: false,
            values: `memory`,
          },
          {
            name: `memLocAnswer`,
            allowPointers: true,
            values: `memory`,
          }
        ],
        LTE: [
          {
            name: `memLoc1`,
            allowPointers: false,
            values: `memory`,
          },
          {
            name: `memLoc2`,
            allowPointers: false,
            values: `memory`,
          },
          {
            name: `memLocAnswer`,
            allowPointers: true,
            values: `memory`,
          }
        ],
        EQ: [
          {
            name: `memLoc1`,
            allowPointers: false,
            values: `memory`,
          },
          {
            name: `memLoc2`,
            allowPointers: false,
            values: `memory`,
          },
          {
            name: `memLocAnswer`,
            allowPointers: true,
            values: `memory`,
          }
        ],
        AND: [
          {
            name: `memLoc1`,
            allowPointers: false,
            values: `memory`,
          },
          {
            name: `memLoc2`,
            allowPointers: false,
            values: `memory`,
          },
          {
            name: `memLocAnswer`,
            allowPointers: true,
            values: `memory`,
          }
        ],
        OR: [
          {
            name: `memLoc1`,
            allowPointers: false,
            values: `memory`,
          },
          {
            name: `memLoc2`,
            allowPointers: false,
            values: `memory`,
          },
          {
            name: `memLocAnswer`,
            allowPointers: true,
            values: `memory`,
          }
        ],
        XOR: [
          {
            name: `memLoc1`,
            allowPointers: false,
            values: `memory`,
          },
          {
            name: `memLoc2`,
            allowPointers: false,
            values: `memory`,
          },
          {
            name: `memLocAnswer`,
            allowPointers: true,
            values: `memory`,
          }
        ],
        NOT: [
          {
            name: `memLocInput`,
            allowPointers: false,
            values: `memory`,
          },
          {
            name: `memLocOutput`,
            allowPointers: false,
            values: `memory`,
          },
        ],
        READ: [
          {
            name: `memLocTo`,
            allowPointers: false,
            values: `memory`,
          }
        ],
        SEND: [
          {
            name: `memLocFrom`,
            allowPointers: false,
            values: `memory`,
          }
        ]
      },
    };
  },
  watch: {
    nextInstructionFormComputed: {
      deep: true,
      immediate: true,
      handler: function (newVal, oldVal) {
        if(oldVal === undefined || newVal.nextInstruction !== oldVal.nextInstruction) {
          newVal.args = this.nextInstructionArgs.map(arg => {
            arg.value = 1;
            return arg;
          });
          this.nextInstructionForm = newVal;
        }
      }
    },
  },
  computed: {
    nextInstructionFormComputed: function() {
      return Object.assign({}, this.nextInstructionForm);
    },
    nextInstructionArgs: function() {
      return this.instructionArgs[this.nextInstructionForm.nextInstruction];
    },
    nextEmptyInstruction: function() {
      let i = 0;
      while(i < 20 && this.programSegment.values[i] !== null) {
        i += 1;
      }
      return i;
    },
  },
  methods: {
    runProgram: function() {

    },
    executeInstruction: function() {

      this.programCounter += 1;
    },
    addInstruction: function() {
      let newInstruction = {
        name: this.nextInstructionForm.nextInstruction,
        args: this.nextInstructionForm.args.map(a => { return { ...a} } ),
      };
      Vue.set(this.programSegment.values, this.nextEmptyInstruction, newInstruction);
    },
  },
  mounted: function() {
    // Set up the memory segments
    for(let i = 0; i < this.dataSegment.size; i++) {
      this.dataSegment.values.push(null);
    }
    for(let i = 0; i < this.programSegment.size; i++) {
      this.programSegment.values.push(null);
    }
  },
  template: `
  <div class="row py-3">
  <!-- State -->
  <div class="col-6">
    <!-- I/O -->
    <div class="row py-2">
      <div class="col-6">
        <h6> Input </h6>
        <input type="text" class="form-control"/>
      </div>
      <div class="col-6">
        <h6> Output </h6>
        <input type="text" class="form-control"/>
      </div>
    </div>
    <!-- PC -->
    <div class="row py-2">
      <div class="col-6"> <h6> Program Counter</h6></div>
      <div class="col-6"> <span class="form-control">{{ programCounter }}</span> </div>
    </div>
    <!-- Data Segments -->
    <div class="row py-2">
      <div class="col-6"> 
        <div class="row"> <div class="col"> <h6> Program Segment</h6> </div> </div>
        <div class="row py-1" v-for="(instruction, index) in programSegment.values" :key="index"> 
          <div class="col"> 
            <instruction :instruction="instruction" :highlight="index === programCounter - 1"></instruction>
          </div> 
        </div>
      </div>
      <div class="col-6"> 
        <div class="row"> <div class="col"> <h6> Data Segment</h6> </div> </div>
        <div class="row py-1" v-for="(instruction, index) in dataSegment.values" :key="index"> 
          <div class="col"> 
            <span class="form-control"> </span> 
          </div> 
        </div>
      </div>
    </div>
  </div>
  <!-- IDE -->
  <div class="col-6">
    <!-- Control -->
    <div class="row py-3"> 
      <div class="col-4"> <button class="btn btn-success" @click="runProgram">Run Program</button></div>
      <div class="col-4"> <button class="btn btn-secondary" @click="addInstruction">Add Instruction</button></div>
      <div class="col-4"> <button class="btn btn-warning" @click="executeInstruction">Execute Next Instruction</button></div>
    </div>
    <!-- Commands -->
    <div class="row"> 
      <div class="col"><h6> Create Command: </h6></div>
      <div class="col">
        <select class="form-control" v-model="nextInstructionForm.nextInstruction">
          <option value="COPY">COPY</option>
          <option value="GOTO">GOTO</option>
          <option value="IF">IF</option>
          <option value="ADD">ADD</option>
          <option value="SUB">SUB</option>
          <option value="MUL">MUL</option>
          <option value="SUB">SUB</option>
          <option value="DIV">DIV</option>
          <option value="GT">GT</option>
          <option value="GTE">GTE</option>
          <option value="LT">LT</option>
          <option value="LTE">LTE</option>
          <option value="EQ">EQ</option>
          <option value="AND">AND</option>
          <option value="OR">OR</option>
          <option value="XOR">XOR</option>
          <option value="NOT">NOT</option>
          <option value="READ">READ</option>
          <option value="SEND">SEND</option>
        </select>
      </div>
    </div>
    <div class="row py-3" v-for="(input, index) in nextInstructionForm.args" :key="index"> 
      <div class="col-4" v-if="input.allowPointers">Pointer? <input type="checkbox" class="form-control" v-model="input.pointer"/></div>
      <div class="col-4"> 
        {{ input.name }}: 
        <select v-if="typeof(input.values) === 'string' && input.values==='memory'" class="form-control" v-model="input.value">
          <option v-for="(memLoc, index) in dataSegment.values" :key="index" :value="index + 1"> {{index + 1}}</option>
        </select>
      </div>
    </div>
  </div>
</div> 
  `,
})

Vue.component('instruction', {
  props: ['instruction', 'highlight'],
  computed: {
    className: function() {
      return this.highlight ? 'bg-secondary' : '';
    }  
  },
  template: `
    <span>
      <span class="form-control" v-if="instruction" :class="className"> 
        <code>{{ instruction.name }}</code>({{ instruction.args.map(arg => (arg.pointer ? '#' : '') +  arg.value).join(', ') }})
        <i class="fas fa-trash"></i>
      </span> 
      <span class="form-control" v-else> </span> 
    </span>
  `,
});
new Vue({ el: '#vue_assembly' });
